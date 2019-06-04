class Api::V1::DomainNameSystemsController < Api::V1::ApiController
  def index
    response = Services::DomainNameSystems::IndexService.new(params: permitted_params).call
    render json: response[:body], status: :ok
  end

  def create
    response = Services::DomainNameSystems::CreateService.new(params: permitted_create_params).call
    render json: response[:domain_name_system], status: :created
  end
  
  private

  def permitted_params
    params.permit(:include, :exclude, :page, :per_page, :offset)
  end

  def permitted_create_params
    params.require(:domain_name_system).permit(:ip, :hostnames)
  end
end