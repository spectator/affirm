require "faraday"

module Affirm
  class Client
    attr_reader :connection

    def initialize
      @connection = Faraday.new.tap do |conn|
        conn.basic_auth(basic_auth_user, basic_auth_password)
      end
    end

    private

    def basic_auth_user
      Affirm.configuration.public_api_key
    end

    def basic_auth_password
      Affirm.configuration.private_api_key
    end
  end
end
