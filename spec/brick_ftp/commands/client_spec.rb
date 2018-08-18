# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BrickFTP::Commands::Client, type: :lib do
  describe '#get' do
    context 'HTTP 200 OK' do
      it 'return JSON parsed object' do
        stub_request(:get, 'https://subdomain.brickftp.com/path/to/resource.json')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            }
          )
          .to_return(body: '{}')

        rest = BrickFTP::Commands::Client.new('subdomain', 'api-key')
        expect(rest.get('/path/to/resource.json')).to eq({})
      end
    end

    context 'HTTP 404 Not Found' do
      it 'raise exception' do
        stub_request(:get, 'https://subdomain.brickftp.com/path/to/resource.json')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            }
          )
          .to_return(body: 'Not Found', status: 404)

        rest = BrickFTP::Commands::Client.new('subdomain', 'api-key')
        expect { rest.get('/path/to/resource.json') }.to raise_error(BrickFTP::Commands::Client::Error) do |e|
          expect(e.error['http-code']).to eq '404'
          expect(e.error['error']).to eq 'Not Found'
        end
      end
    end
  end

  describe '#post' do
    context 'HTTP 200 OK' do
      it 'return JSON parsed object' do
        stub_request(:post, 'https://subdomain.brickftp.com/path/to/resource.json')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
              'Content-Type' => 'application/json',
            },
            body: '{}'
          )
          .to_return(body: '{}')

        rest = BrickFTP::Commands::Client.new('subdomain', 'api-key')
        expect(rest.post('/path/to/resource.json', {})).to eq({})
      end
    end

    context 'HTTP 400 Bad Request' do
      it 'raise exception' do
        stub_request(:post, 'https://subdomain.brickftp.com/path/to/resource.json')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            },
            body: '{}'
          )
          .to_return(body: '{"error":"invalid","http-code":"400"}', status: 400)

        rest = BrickFTP::Commands::Client.new('subdomain', 'api-key')
        expect { rest.post('/path/to/resource.json', {}) }.to raise_error(BrickFTP::Commands::Client::Error) do |e|
          expect(e.error['http-code']).to eq '400'
          expect(e.error['error']).to eq 'invalid'
        end
      end
    end
  end

  describe '#put' do
    context 'HTTP 200 OK' do
      it 'return JSON parsed object' do
        stub_request(:put, 'https://subdomain.brickftp.com/path/to/resource.json')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
              'Content-Type' => 'application/json',
            },
            body: '{}'
          )
          .to_return(body: '{}')

        rest = BrickFTP::Commands::Client.new('subdomain', 'api-key')
        expect(rest.put('/path/to/resource.json', {})).to eq({})
      end
    end

    context 'HTTP 400 Bad Request' do
      it 'raise exception' do
        stub_request(:put, 'https://subdomain.brickftp.com/path/to/resource.json')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            },
            body: '{}'
          )
          .to_return(body: '{"error":"invalid","http-code":"400"}', status: 400)

        rest = BrickFTP::Commands::Client.new('subdomain', 'api-key')
        expect { rest.put('/path/to/resource.json', {}) }.to raise_error(BrickFTP::Commands::Client::Error) do |e|
          expect(e.error['http-code']).to eq '400'
          expect(e.error['error']).to eq 'invalid'
        end
      end
    end
  end

  describe '#delete' do
    context 'HTTP 200 OK' do
      it 'return JSON parsed object' do
        stub_request(:delete, 'https://subdomain.brickftp.com/path/to/resource.json')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
              'Content-Type' => 'application/json',
            }
          )
          .to_return(body: '{}')

        rest = BrickFTP::Commands::Client.new('subdomain', 'api-key')
        expect(rest.delete('/path/to/resource.json')).to eq({})
      end
    end

    context 'HTTP 400 Bad Request' do
      it 'raise exception' do
        stub_request(:delete, 'https://subdomain.brickftp.com/path/to/resource.json')
          .with(
            basic_auth: %w[api-key x],
            headers: {
              'User-Agent' => 'BrickFTP Client/1.0 (https://github.com/koshigoe/brick_ftp)',
            }
          )
          .to_return(body: '{"error":"invalid","http-code":"400"}', status: 400)

        rest = BrickFTP::Commands::Client.new('subdomain', 'api-key')
        expect { rest.delete('/path/to/resource.json') }.to raise_error(BrickFTP::Commands::Client::Error) do |e|
          expect(e.error['http-code']).to eq '400'
          expect(e.error['error']).to eq 'invalid'
        end
      end
    end
  end
end
