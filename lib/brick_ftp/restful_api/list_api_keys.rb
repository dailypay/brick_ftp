# frozen_string_literal: true

module BrickFTP
  module RESTfulAPI
    # List API keys
    #
    # @see https://developers.files.com/#list-api-keys List API keys
    #
    class ListAPIKeys
      include Command
      using BrickFTP::CoreExt::Hash

      # Returns a list of all API keys for a user on the current site.
      #
      # @param [Integer] id Globally unique identifier of each user.
      #   Each user is given an ID automatically upon creation.
      # @return [Array<BrickFTP::Types::UserAPIKey>] User's API keys
      #
      def call(id)
        res = client.get("/api/rest/v1/users/#{id}/api_keys.json")

        res.map { |i| BrickFTP::Types::UserAPIKey.new(**i.symbolize_keys) }
      end
    end
  end
end
