module Affirm
  class Configuration
    attr_accessor :public_api_key
    attr_accessor :private_api_key
    attr_accessor :environment

    ENDPOINTS = {
      production: "affirm.com",
      sandbox:    "sandbox.affirm.com"
    }

    def initialize
      @environment = :production
    end

    def endpoint
      "https://#{ENDPOINTS[environment]}"
    end
  end

  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    def configuration=(config)
      @configuration = config
    end

    def configure
      yield configuration
    end
  end
end
