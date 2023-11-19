require "helper"

RSpec.describe Affirm::Client do
  before(:all) do
    Affirm.configure do |config|
      config.public_api_key  = "abc"
      config.private_api_key = "xyz"
    end
  end

  context "new instance" do
    it "creates Faraday connection" do
      expect(subject.connection).to be_an_instance_of(Faraday::Connection)
    end
  end

  context "post request" do
    before(:all) do
      @stubs = Faraday::Adapter::Test::Stubs.new do |stub|
        stub.post("/api/v2/foo") { [200, {}, ""] }
        stub.post("/api/v2/bar", '{"key":"value"}') { [200, {}, ""] }
      end
    end

    after(:all) { @stubs.verify_stubbed_calls }

    before do
      subject.connection.builder.handlers.pop
      subject.connection.adapter(:test, @stubs)
    end

    it "sets basic auth header" do
      response = subject.post("foo", {})
      expect(response.env.request_headers["Authorization"]).to eq("Basic YWJjOnh5eg==")
    end

    it "makes request to full url" do
      response = subject.post("foo", {})
      expect(response.env.url.to_s).to eq("https://api.affirm.com/api/v2/foo")
    end

    it "makes request to specified path with no leading slash specified" do
      expect(subject.post("foo")).to be_success
    end

    it "makes request to specified path with leading slash specified" do
      expect(subject.post("/foo")).to be_success
    end

    it "makes request with json data" do
      expect(subject.post("/bar", { key: "value" })).to be_success
    end
  end

  context "get request" do
    before(:all) do
      @stubs = Faraday::Adapter::Test::Stubs.new do |stub|
        stub.get("/api/v2/foo") { [200, {}, ""] }
        stub.get("/api/v2/bar?key=value") { [200, {}, ""] }
      end
    end

    after(:all) { @stubs.verify_stubbed_calls }

    before do
      subject.connection.builder.handlers.pop
      subject.connection.adapter(:test, @stubs)
    end

    it "sets basic auth header" do
      response = subject.get("foo", {})
      expect(response.env.request_headers["Authorization"]).to eq("Basic YWJjOnh5eg==")
    end

    it "makes request to full url" do
      response = subject.get("foo", {})
      expect(response.env.url.to_s).to eq("https://api.affirm.com/api/v2/foo")
    end

    it "makes request to specified path with no leading slash specified" do
      expect(subject.get("foo")).to be_success
    end

    it "makes request to specified path with leading slash specified" do
      expect(subject.get("/foo")).to be_success
    end

    it "makes request with params" do
      expect(subject.get("/bar", { key: "value" })).to be_success
    end
  end
end
