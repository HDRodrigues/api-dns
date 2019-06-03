module Services
  module DomainNameSystems
    class IndexService
      include Services::Concerns::ActionService

      def initialize(overrides={})
        params = overrides.fetch(:params, nil)
        include_params = params.fetch(:include, nil)
        exclude_params = params.fetch(:exclude, nil)
        @page = params.fetch(:page, 1)
        @per_page = params.fetch(:per_page, nil)
        @offset = params.fetch(:offset, nil)

        @include_params = include_params.split(',') if include_params.present?
        @exclude_params = exclude_params.split(',') if exclude_params.present?
      end

      def call
        include_query = DomainNameSystem.in_hostnames(@include_params)
        exclude_query = DomainNameSystem.not_in_hostnames(@exclude_params)
        dns = include_query.blacklist(exclude_query.ids)
        dns = dns.page(@page).per(@per_page).padding(@offset)
        
        pagination = paginate(dns)
        domain_name_systems = Services::DomainNameSystems::FormatService.new(dns: dns).call

        { body:  pagination.merge(domain_name_systems) }
      end
    end
  end 
end