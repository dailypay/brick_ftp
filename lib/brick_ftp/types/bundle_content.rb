# frozen_string_literal: true

module BrickFTP
  module Types
    # An element of bundle contents
    #
    # @see https://developers.brickftp.com/#list-bundle-contents List bundle contents
    #
    # ATTRIBUTE | TYPE    | DESCRIPTION
    # --------- | ------- | -----------
    # path      | string  | undocumented
    # type      | string  | undocumented
    # size      | integer | undocumented
    #
    BundleContent = Struct.new(
      'BundleContent',
      :path,
      :type,
      :size,
      keyword_init: true
    )
  end
end
