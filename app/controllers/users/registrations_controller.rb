# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  include ErrorResponseHandler
  respond_to :json
  before_action :handle_referral, only: :create

  private

  def respond_with(resource, _opts = {})
    @current_user = resource
    render_errors resource: @current_user and return unless @current_user.persisted?

    # code to complete the referral object.
    if @referral.present?
      @referral.referred_id = @current_user.id
      @referral.status = 1
      @referral.save
    end
  end

  def handle_referral
    return if params[:token].blank?

    @referral = Referral.where(token: params[:token]).last
    render_custom_error message: "no referral found, if you wish to continue signup now" and return if @referral.blank?

    render_custom_error message: "referral link already used, if you wish to continue signup now" and return if @referral.completed?
  end
end
