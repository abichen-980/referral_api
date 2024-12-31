# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  include ErrorResponseHandler
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    @current_user = resource
  end

  def respond_to_on_destroy
    token = request.headers["Authorization"].split(" ").last
    decoded_token = Warden::JWTAuth::TokenDecoder.new.call(token)
    User.find(decoded_token["sub"])
    render json: { message: "logged out succesfully." }, status: :ok
  rescue Exception
    render_unauthorized message: "no active session"
  end
end
