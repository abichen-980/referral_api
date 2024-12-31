module ErrorResponseHandler
  extend ActiveSupport::Concern

  private

  def render_errors(path: "general/errors", resource:, http_status: 422)
    @resource = resource
    render path, status: http_status
  end

  def render_unauthorized(message:)
    render json: { error: message }, status: :unauthorized
  end

  def render_custom_error(message:, status: :not_found)
    render json: { error: message }, status: status
  end
end
