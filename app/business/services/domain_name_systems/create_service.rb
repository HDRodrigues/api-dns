module Services
  module DomainNameSystems
    class CreateService
      include Services::Concerns::ActionService

      def initialize(overrides={})
        params = overrides.fetch(:params, nil)
        @ip = params.fetch(:ip)
        @hostnames = params.fetch(:hostnames, [])
      end

      def call
        IPAddr.new(@ip)
        dns = DomainNameSystem.create!(ip: @ip)
        @hostnames.split(',').each do |hostname|
          dns.hostnames << Hostname.find_or_create_by(name: hostname)
        end

        { domain_name_system: dns }
      end
    end
  end 
end