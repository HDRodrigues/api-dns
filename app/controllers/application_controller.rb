class ApplicationController < ActionController::API
  rescue_from StandardError, with: :render_internal_server_error

  def render_internal_server_error(exception)
    render json: { error: 'Something went wrong, please contact support@libring.com' }, status: :internal_server_error
  end

end
