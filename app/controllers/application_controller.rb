class ApplicationController < ActionController::API
  rescue_from StandardError, with: :render_internal_server_error
  rescue_from IPAddr::InvalidAddressError, with: :render_ip_error
  rescue_from ActiveRecord::RecordInvalid, with: :render_invalid_fields

  def render_internal_server_error(exception)
    render json: { error: 'Something went wrong, please try again or contact our support.' }, status: :internal_server_error
  end

  def render_ip_error(exception)
    render json: { error: 'Ip address not allowed, please send a valide ip.' }, status: :unprocessable_entity
  end

  def render_invalid_fields(exception)
    render json: { error: "The #{controller_name.singularize} can't be saved due to validation errors.",
                   details: exception.record.errors.full_messages }, status: :unprocessable_entity
  end
end
