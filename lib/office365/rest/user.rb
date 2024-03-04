# frozen_string_literal: true

require_relative "request"

module Office365
  module REST
    module User
      def me
        profile_uri = ["/", Office365::API_VERSION, "/me"].join
        Models::User.new(Request.new(access_token, debug: debug).get(profile_uri))
      end

      def all_users(args = {})
        wrap_results(args.merge(kclass: Models::User, base_uri: "/users"))
      end

      def user(user_id, args = {})      
        Models::User.new(Request.new(access_token, debug: debug).get("/#{Office365::API_VERSION}/users/#{user_id}"))
      end
    end
  end
end
