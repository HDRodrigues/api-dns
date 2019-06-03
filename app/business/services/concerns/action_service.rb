module Services
  module Concerns
    module ActionService
      extend ActiveSupport::Concern

      included do
        def paginate(relation)
          Services::Shared::PaginationService.new(relation: relation).call
        end
      end
    end
  end
end
