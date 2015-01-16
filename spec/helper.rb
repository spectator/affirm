require "affirm"
require "byebug"

RSpec.configure do |config|
  config.before(:all) do
    Faraday.default_adapter = :test
  end
end
