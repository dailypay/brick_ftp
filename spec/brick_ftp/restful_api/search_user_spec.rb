# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::SearchUser, type: :lib do
  describe '#call' do
    context 'given correct username' do
      it 'return User object' do
        expected_user = BrickFTP::Types::User.new(
          'id': 1234,
          'username': 'user',
          'authentication_method': 'password',
          'last_login_at': nil,
          'authenticate_until': nil,
          'name': nil,
          'email': 'user@example.com',
          'notes': nil,
          'group_ids': '',
          'ftp_permission': true,
          'sftp_permission': true,
          'dav_permission': true,
          'restapi_permission': true,
          'attachments_permission': true,
          'self_managed': true,
          'require_password_change': false,
          'require_2fa': false,
          'allowed_ips': nil,
          'user_root': '',
          'time_zone': 'Eastern Time (US & Canada)',
          'language': '',
          'ssl_required': 'use_system_setting',
          'site_admin': true,
          'password_set_at': nil,
          'receive_admin_alerts': true,
          'subscribe_to_newsletter': false,
          'last_protocol_cipher': nil,
          'lockout_expires': nil,
          'admin_group_ids': []
        )

        stub_request(:get, 'https://subdomain.brickftp.com/api/rest/v1/users.json?q[username]=user')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            }
          )
          .to_return(body: [expected_user.to_h].to_json)

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        command = BrickFTP::RESTfulAPI::SearchUser.new(rest)
        user = command.call('user')

        expect(user).to eq expected_user
      end
    end

    context 'User not found' do
      it 'return nil' do
        stub_request(:get, 'https://subdomain.brickftp.com/api/rest/v1/users.json?q[username]=a%26b')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            }
          )
          .to_return(body: '[]')

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        command = BrickFTP::RESTfulAPI::SearchUser.new(rest)
        user = command.call('a&b')

        expect(user).to be_nil
      end
    end
  end
end
