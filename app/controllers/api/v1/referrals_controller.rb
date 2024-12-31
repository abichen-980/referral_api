module Api
  module V1
    class ReferralsController < ::ApplicationController
      def index
        @referrals = current_user.referrals.order("created_at DESC").page(params[:page]||1).per(10)
        render json: { message: "no referrals found" }, status: :ok and return if @referrals.empty?
      end


      def create
        @referral = current_user.referrals.new(referral_params)
        render_errors resource: @referral and return unless @referral.save

        render "show"
      end

      private

      def referral_params
        params.require(:referral).permit(:email)
      end
    end
  end
end
