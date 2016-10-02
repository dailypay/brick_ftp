require 'net/https'
require 'json'

module BrickFTP
  class HTTPClient
    class Error < StandardError
      def initialize(response)
        begin
          error = JSON.parse(response.body)
        rescue
          error = { 'http-code' => response.code, 'error' => "#{response.message}, #{response.body}" }
        end

        case
        when error.key?('http-code')
          super "#{error['http-code']}: #{error['error']}"
        when error.key?('errors')
          super error['errors'].join('. ')
        else
          super 'unknown error.'
        end
      end
    end

    USER_AGENT = 'BrickFTP Client/0.1 (https://github.com/koshigoe/brick_ftp)'.freeze

    def initialize
      @conn = Net::HTTP.new(BrickFTP.config.api_host, 443)
      @conn.use_ssl = true
    end

    def get(path)
      case res = request(:get, path)
      when Net::HTTPSuccess
        JSON.parse(res.body)
      else
        # TODO: redirect
        raise Error, res
      end
    end

    def post(path, params: {})
      case res = request(:post, path, params: params)
      when Net::HTTPSuccess, Net::HTTPCreated
        JSON.parse(res.body)
      else
        # TODO: redirect
        raise Error, res
      end
    end

    def put(path, params: {})
      case res = request(:put, path, params: params)
      when Net::HTTPSuccess
        JSON.parse(res.body)
      else
        # TODO: redirect
        raise Error, res
      end
    end

    def delete(path)
      case res = request(:delete, path)
      when Net::HTTPSuccess
        true
      else
        # TODO: redirect
        raise Error, res
      end
    end

    private

    def request(method, path, params: {}, headers: {})
      req = Net::HTTP.const_get(method.to_s.capitalize).new(path, headers)
      req['Content-Type'] = 'application/json'
      req['User-Agent'] = USER_AGENT

      case
      when BrickFTP.config.session
        req['Cookie'] = BrickFTP::API::Authentication.cookie(BrickFTP.config.session).to_s
      when BrickFTP.config.api_key
        req.basic_auth(BrickFTP.config.api_key, 'x')
      end

      req.body = params.to_json unless params.empty?

      @conn.request(req)
    end
  end
end
