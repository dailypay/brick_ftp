# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::Client, type: :lib do
  describe '#initialize' do
    around do |example|
      subdomain = ENV['BRICK_FTP_SUBDOMAIN']
      api_key = ENV['BRICK_FTP_API_KEY']
      ENV.update('BRICK_FTP_SUBDOMAIN' => 'env-subdomain', 'BRICK_FTP_API_KEY' => 'env-api_key')

      example.run

      ENV.update('BRICK_FTP_SUBDOMAIN' => subdomain, 'BRICK_FTP_API_KEY' => api_key)
    end

    context 'omit argument' do
      it 'use environment variables' do
        client = BrickFTP::Client.new

        aggregate_failures do
          expect(client.subdomain).to eq 'env-subdomain'
          expect(client.api_key).to eq 'env-api_key'
        end
      end
    end

    context 'pass arguments' do
      it 'use arguments' do
        client = BrickFTP::Client.new(subdomain: 'subdomain', api_key: 'api_key')

        aggregate_failures do
          expect(client.subdomain).to eq 'subdomain'
          expect(client.api_key).to eq 'api_key'
        end
      end
    end
  end

  describe 'delegate' do
    context 'command found' do
      it 'dipatch command' do
        client = BrickFTP::Client.new(subdomain: 'subdomain', api_key: 'api-key')
        id = double

        expect(BrickFTP::RESTfulAPI::GetUser).to receive_message_chain(:new, :call).with(client.api_client).with(id)
        expect(client).to be_respond_to(:get_user)
        client.get_user(id)
      end
    end

    context 'command not found' do
      it 'raise NoMethodError' do
        client = BrickFTP::Client.new(subdomain: 'subdomain', api_key: 'api-key')

        expect(client).not_to be_respond_to(:command_not_found)
        expect { client.command_not_found }.to raise_error(NoMethodError)
      end
    end
  end
end
