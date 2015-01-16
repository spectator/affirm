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

    it "sets json handlers" do
      expect(
        subject.connection.builder.handlers
      ).to include(FaradayMiddleware::EncodeJson, FaradayMiddleware::ParseJson)
    end

    it "sets basic auth header" do
      expect(subject.connection.headers["Authorization"]).to eq("Basic YWJjOnh5eg==")
    end
  end

  context "post request" do
    let(:stubs) do
      Faraday::Adapter::Test::Stubs.new do |stub|
        stub.post("/api/v2/foo") { [200, {}, nil] }
      end
    end

    before do
      subject.connection.adapter(:test, stubs)
    end

    it "makes request to full url" do
      response = subject.post("foo")
      expect(response.env.url.to_s).to eq("https://affirm.com/api/v2/foo")
    end

    it "makes request to specified path with no leading slash specified" do
      expect(subject.post("foo")).to be_success
    end

    it "makes request to specified path with leading slash specified" do
      expect(subject.post("/foo")).to be_success
    end

    it "makes request with json data" do
      expect(subject.post("/foo", { key: "value" })).to be_success
    end
  end
end
