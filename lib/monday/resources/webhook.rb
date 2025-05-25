# frozen_string_literal: true

require_relative "base"

module Monday
  module Resources
    # Represents Monday.com's webhooks resource.
    class Webhook < Base
      DEFAULT_SELECT = %w[id board_id event config].freeze

      # Retrieves webhooks for a board.
      #
      # @param board_id [Integer] the board's unique identifier
      # @param app_webhooks_only [Boolean] returns only webhooks created by the app
      # @param select [Array<String>] the list of fields to return.
      # @return [Monday::Response] the response from the API.
      def query(board_id:, app_webhooks_only: false, select: DEFAULT_SELECT)
        args = { board_id: board_id }
        args[:app_webhooks_only] = app_webhooks_only if app_webhooks_only

        request_query = "query{webhooks#{Util.format_args(args)}{#{Util.format_select(select)}}}"
        make_request(request_query)
      end

      # Creates a webhook subscription.
      #
      # @param board_id [Integer] the board's unique identifier
      # @param url [String] the webhook URL (max 255 characters)
      # @param event [String] the event to listen to
      # @param config [String] optional JSON configuration for specific events
      # @param select [Array<String>] the list of fields to return.
      # @return [Monday::Response] the response from the API.
      def create(board_id:, url:, event:, config: nil, select: DEFAULT_SELECT)
        args_str = "board_id: #{board_id}, url: \"#{url}\", event: #{event}"
        args_str += ", config: \"#{config}\"" if config

        query = "mutation{create_webhook(#{args_str}){#{Util.format_select(select)}}}"
        make_request(query)
      end

      # Deletes a webhook.
      #
      # @param id [Integer] the webhook's unique identifier
      # @param select [Array<String>] the list of fields to return.
      # @return [Monday::Response] the response from the API.
      def delete(id:, select: %w[id board_id])
        query = "mutation{delete_webhook(id: #{id}){#{Util.format_select(select)}}}"
        make_request(query)
      end
    end
  end
end
