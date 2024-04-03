# frozen_string_literal: true

require_relative "./concerns/base"

module Office365
  module REST
    module Event
      include Concerns::Base

      # params: args => { next_link: (nil / next_page_url) }
      # response { results: [], next_link: '...' }
      def events(args = {})
        wrap_results(args.merge(kclass: Models::Event, base_uri: "/me/events"))
      end

      def user_events(user_id, args = {})
        raise Error, "Event.user_events user id must be supplied" if user_id.nil?

        wrap_results(args.merge(kclass: Models::Event, base_uri: "/users/#{user_id}/calendar/events"))
      end

      def user_create_event(user_id:, args: {}, params: {})
        raise Error, "Event.user_create_event user id must be supplied" if user_id.nil?

        response  = post_request(args: args.merge(kclass: Models::Event, base_uri: "/users/#{user_id}/calendar/events"), params: params)
        {
          event: Models::Event.new(response)
        }
      end
    end
  end
end
