module Services
  module DomainNameSystems
    class FormatService
      def initialize(overrides={})
        @domain_name_systems = overrides[:dns]
      end

      def call
        response = { :domain_name_systems => []}
        @domain_name_systems.each do |dns|
          response[:domain_name_systems] <<  {
            id: dns.id,
            ip: dns.ip,
            hostnames: dns.hostnames.pluck(:name)
          }
        end
        response
      end
    end
  end
end