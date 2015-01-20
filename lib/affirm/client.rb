require "faraday"
require "faraday_middleware"

module Affirm
  class Client
    attr_reader :connection

    attr_reader :url_prefix
    private :url_prefix

    class << self
      def request(method, path, **data)
        new.public_send(method, path, data)
      end
    end

    def initialize
      @url_prefix = "/api/v2"
      @connection = Faraday.new(Affirm.configuration.endpoint) do |conn|
        conn.basic_auth(basic_auth_user, basic_auth_password)
        conn.request  :json
        conn.response :json, content_type: /\bjson$/
        conn.adapter  Faraday.default_adapter
      end
    end

    def post(path, **data)
      normalized_path = url_prefix + normalize_path(path)
      connection.post(normalized_path, data)
    end

    private

    def basic_auth_user
      Affirm.configuration.public_api_key
    end

    def basic_auth_password
      Affirm.configuration.private_api_key
    end

    def normalize_path(path)
      Faraday::Utils.normalize_path(path)
    end
  end
end
