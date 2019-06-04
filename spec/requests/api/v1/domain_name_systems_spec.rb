require 'rails_helper'

RSpec.describe 'API::V1::DomainNameSystems', type: :request do

  describe 'GET /api/v1/dns' do
    context 'when there are no params' do
      let!(:hostname_1) { FactoryBot.create(:hostname, name: 'amet.com') }
      let!(:hostname_2) { FactoryBot.create(:hostname, name: 'dolor.com') }

      before do
        FactoryBot.create_list(:domain_name_system, 10)
      end

      it 'returns status ok' do
        get api_v1_dns_path

        expect(response).to have_http_status(:ok)
      end

      it 'returns the expected total items' do
        get api_v1_dns_path

        parsed_response = JSON.parse(response.body)

        expect(parsed_response["total_items"]).to be_eql(10)
      end
    end

    context 'when include params is used' do
      let!(:hostname_1) { FactoryBot.create(:hostname, name: 'amet.com') }
      let!(:hostname_2) { FactoryBot.create(:hostname, name: 'dolor.com') }

      before do
        FactoryBot.create_list(:domain_name_system, 2, hostnames: [hostname_1, hostname_2])
        FactoryBot.create_list(:domain_name_system, 10)
      end

      it 'returns status ok' do
        get api_v1_dns_path(include: "#{hostname_1.name},#{hostname_2.name}")

        expect(response).to have_http_status(:ok)
      end

      it 'returns the expected total items' do
        get api_v1_dns_path(include: "#{hostname_1.name},#{hostname_2.name}")

        parsed_response = JSON.parse(response.body)

        expect(parsed_response["total_items"]).to be_eql(2)
      end
    end

    context 'when exclude params is used' do
      let!(:hostname_1) { FactoryBot.create(:hostname, name: 'amet.com') }
      let!(:hostname_2) { FactoryBot.create(:hostname, name: 'dolor.com') }

      before do
        FactoryBot.create(:domain_name_system, hostnames: [hostname_1, hostname_2])
        FactoryBot.create_list(:domain_name_system, 10)
      end

      it 'returns status ok' do
        get api_v1_dns_path(exclude: "#{hostname_1.name},#{hostname_2.name}")

        expect(response).to have_http_status(:ok)
      end

      it 'returns the expected total items' do
        get api_v1_dns_path(exclude: "#{hostname_1.name},#{hostname_2.name}")

        parsed_response = JSON.parse(response.body)

        expect(parsed_response["total_items"]).to be_eql(10)
      end
    end

    context 'when the hostname does not exist' do
      before do
        FactoryBot.create(:domain_name_system)
      end

      it 'returns status ok' do
        get api_v1_dns_path(include: 'sit.com')

        expect(response).to have_http_status(:ok)
      end

      it 'returns a empty array' do
        get api_v1_dns_path(include: 'sit.com')

        parsed_response = JSON.parse(response.body)

        expect(parsed_response["domain_name_systems"]).to be_empty
      end

      it 'returns the dns' do
        get api_v1_dns_path(exclude: 'sit.com')

        parsed_response = JSON.parse(response.body)

        expect(parsed_response["total_items"]).to be_eql(1)
      end
    end
  end

  describe 'POST /api/v1/dns' do
    
    context 'when the params is valide' do
      let(:dns_params){ {:params => {:domain_name_system => {:ip => "1.1.1.1", :hostnames => 'amet.com,dolor.com'}}} } 
      it 'returns status created' do
        post "/api/v1/dns", dns_params 
        expect(response).to have_http_status(:created)
      end

      it 'returns the dns saved' do
        post "/api/v1/dns", dns_params
        parsed_response = JSON.parse(response.body)

        expect(parsed_response["id"]).to be_kind_of(Integer)
        expect(parsed_response["ip"]).to be_eql("1.1.1.1")
      end
    end

    context 'when the params has just dns' do
      let(:dns_params){ {:params => { :domain_name_system => {:ip => "1.1.1.1"}}} } 

      it 'returns status created' do
        post "/api/v1/dns", dns_params
        
        expect(response).to have_http_status(:created)
      end

      it 'returns the dns saved' do
        post "/api/v1/dns", dns_params
        
        parsed_response = JSON.parse(response.body)

        expect(parsed_response["id"]).to be_kind_of(Integer)
        expect(parsed_response["ip"]).to be_eql("1.1.1.1")
      end
    end

    context 'when is not a valide ip' do
      let(:dns_params){ {:params => { :domain_name_system => {:ip => "1.1.1"}}} } 
      
      it 'returns status unprocessable_entity' do
        post "/api/v1/dns", dns_params
        
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns an error message' do
        post "/api/v1/dns", dns_params
        parsed_response = JSON.parse(response.body)

        expect(parsed_response['error']).to include('Ip address not allowed, please send a valide ip.')
      end
    end

    context 'when ip is already taken' do
      let(:dns_params){ {:params => { :domain_name_system => {:ip => "1.1.1.1"}}} } 
      before do
        FactoryBot.create(:domain_name_system, ip: "1.1.1.1")
      end

      it 'returns status unprocessable_entity' do
        post "/api/v1/dns", dns_params
        
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns an error' do
        post "/api/v1/dns", dns_params
        parsed_response = JSON.parse(response.body)

        expect(parsed_response['error']).to include("The domain_name_system can't be saved due to validation errors.")
        expect(parsed_response['details']).to include("Ip has already been taken")
      end
    end
  end
end