# frozen_string_literal: true

require 'erb'

module BrickFTP
  module RESTfulAPI
    # Get folder size
    #
    # @see https://developers.files.com/#get-folder-size Get folder size
    #
    class GetFolderSize
      include Command

      # Returns the size (in bytes) of the specified folder, recursively.
      #
      # @param [String] path
      # @return [Integer]
      #
      def call(path)
        res = client.get("/api/rest/v1/folders/#{ERB::Util.url_encode(path)}?action=size")
        res['data']['size']
      end
    end
  end
end
