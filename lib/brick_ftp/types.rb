# frozen_string_literal: true

module BrickFTP
  module Types
    autoload :User, 'brick_ftp/types/user'
    autoload :UserAPIKey, 'brick_ftp/types/user_api_key'
    autoload :UserPublicKey, 'brick_ftp/types/user_public_key'
    autoload :Group, 'brick_ftp/types/group'
    autoload :GroupMembership, 'brick_ftp/types/group_membership'
    autoload :Permission, 'brick_ftp/types/permission'
    autoload :Notification, 'brick_ftp/types/notification'
    autoload :History, 'brick_ftp/types/history'
    autoload :Bundle, 'brick_ftp/types/bundle'
    autoload :BundleContent, 'brick_ftp/types/bundle_content'
    autoload :FileInBundle, 'brick_ftp/types/file_in_bundle'
    autoload :BundleZip, 'brick_ftp/types/bundle_zip'
    autoload :Behavior, 'brick_ftp/types/behavior'
    autoload :File, 'brick_ftp/types/file'
    autoload :FolderContentsCount, 'brick_ftp/types/folder_contents_count'
    autoload :Upload, 'brick_ftp/types/upload'
    autoload :SiteUsage, 'brick_ftp/types/site_usage'
  end
end
