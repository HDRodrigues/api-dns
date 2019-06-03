module Services
  module Shared
    class PaginationService
      def initialize(overrides = {})
        @relation = overrides.fetch(:relation)
      end

      def call
        {
          total_items: @relation.total_count,
          number_of_items: @relation.size,
          total_pages: @relation.total_pages,
          current_page: @relation.current_page
        }
      end

    end
  end
end
