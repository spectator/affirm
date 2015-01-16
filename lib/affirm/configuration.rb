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
      "https://#{ENDPOINTS[environment]}/api/v2"
    end
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configuration=(config)
    @configuration = config
  end

  def self.configure
    yield configuration
  end
end
