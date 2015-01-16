require "faraday"
require "faraday_middleware"

module Affirm
  class Client
    attr_reader :connection

    def initialize
      @url_prefix = "/api/v2"
      @connection = Faraday.new do |conn|
        conn.basic_auth(basic_auth_user, basic_auth_password)
        conn.request  :json
        conn.response :json, content_type: /\bjson$/
        conn.adapter  Faraday.default_adapter
      end
    end

    private

    attr_reader :url_prefix

    def basic_auth_user
      Affirm.configuration.public_api_key
    end

    def basic_auth_password
      Affirm.configuration.private_api_key
    end
  end
end
