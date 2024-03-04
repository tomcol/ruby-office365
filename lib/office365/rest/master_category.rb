# frozen_string_literal: true

require_relative "./concerns/base"

module Office365
  module REST
    module MasterCategory
      include Concerns::Base

      def list_master_categories(user_id, args = {})
        raise Error, "MasterCategory.list_master_categories user id must be supplied" if user_id.nil?

        wrap_results(args.merge(kclass: Models::MasterCategory, base_uri: "/users/#{user_id}/outlook/masterCategories"))
      end
    end
  end
end
