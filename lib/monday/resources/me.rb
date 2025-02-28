# frozen_string_literal: true

require_relative "base"

module Monday
  module Resources
    # Represents Monday.com's me resource.
    #
    # Retrieves metadata about the user whose API key is being used.
    # This includes comprehensive details such as account, profile, and team data.
    # In the spirit of simplicity and clarity, this implementation lets you
    # customize the fields returned via the `select` parameter.
    class Me < Base
      DEFAULT_SELECT = %w[
        id
        name
        email
        url
        account
        birthday
        country_code
        created_at
        current_language
        join_date
        enabled
        is_admin
        is_guest
        is_pending
        is_verified
        is_view_only
        last_activity
        location
        mobile_phone
        phone
        photo_original
        photo_small
        photo_thumb
        photo_thumb_small
        photo_tiny
        sign_up_product_kind
        teams
        time_zone_identifier
        title
        utc_hours_diff
      ].freeze

      # Retrieves the authenticated user's details.
      #
      # @param select [Array<String>] the list of fields to return.
      #   Defaults to all available fields.
      # @return [Monday::Response] the response from the API.
      def query(select: DEFAULT_SELECT)
        request_query = "query { me { #{Util.format_select(select)} } }"
        make_request(request_query)
      end
    end
  end
end
