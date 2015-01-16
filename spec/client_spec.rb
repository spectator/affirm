require "helper"

RSpec.describe Affirm::Client do
  context "new instance" do
    it "creates Faraday connection" do
      expect(subject.connection).to be_an_instance_of(Faraday::Connection)
    end
  end

  context "with api keys set" do
    before do
      Affirm.configure do |config|
        config.public_api_key  = "abc"
        config.private_api_key = "xyz"
      end
    end

    it "sets basic auth header" do
      expect(subject.connection.headers["Authorization"]).to eq("Basic YWJjOnh5eg==")
    end
  end
end
