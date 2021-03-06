# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::RESTfulAPI::GetPublicKey, type: :lib do
  describe '#call' do
    context 'correct request' do
      it 'return User Public key object' do
        expected_user_public_key = BrickFTP::Types::UserPublicKey.new(
          id: 12_345,
          title: 'test',
          fingerprint: 'finger-pring',
          created_at: '2018-08-17T08:16:52-04:00'
        )

        stub_request(:get, 'https://subdomain.files.com/api/rest/v1/public_keys/12345.json')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            }
          )
          .to_return(body: expected_user_public_key.to_h.to_json)

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        command = BrickFTP::RESTfulAPI::GetPublicKey.new(rest)

        expect(command.call(12_345)).to eq(expected_user_public_key)
      end
    end

    context 'Public key not found' do
      it 'raise exception' do
        stub_request(:get, 'https://subdomain.files.com/api/rest/v1/public_keys/1234.json')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            }
          )
          .to_return(body: '[]', status: 404)

        rest = BrickFTP::RESTfulAPI::Client.new('subdomain', 'api-key')
        command = BrickFTP::RESTfulAPI::GetPublicKey.new(rest)

        expect { command.call(1234) }.to raise_error(BrickFTP::RESTfulAPI::Client::Error)
      end
    end
  end
end
