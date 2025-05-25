# frozen_string_literal: true

require_relative "base"

module Monday
  module Resources
    # Represents Monday.com's users resource.
    class User < Base
      DEFAULT_SELECT = %w[id name email photo_thumb title].freeze

      # Retrieves users by their IDs.
      #
      # @param args [Hash] arguments for the query, supports:
      #   - ids: Array of user IDs to retrieve
      #   - emails: Array of user emails to retrieve
      #   - kind: Type of users (all, guests, non_guests, non_pending)
      #   - limit: Number of users to return
      # @param select [Array<String>] the list of fields to return.
      # @return [Monday::Response] the response from the API.
      def query(args: {}, select: DEFAULT_SELECT)
        request_query = "query{users#{Util.format_args(args)}{#{Util.format_select(select)}}}"
        make_request(request_query)
      end
    end
  end
end
