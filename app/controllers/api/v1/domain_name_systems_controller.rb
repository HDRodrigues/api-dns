class Api::V1::DomainNameSystemsController < Api::V1::ApiController
  def index
    response = Services::DomainNameSystems::IndexService.new(params: permitted_params).call
    render json: response[:body], status: :ok
  end

  def permitted_params
    params.permit(:include, :exclude, :page, :per_page, :offset)
  end
end