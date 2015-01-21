module Affirm
  class FailureResult
    extend Forwardable
    def_delegators :response, :status, :success?

    attr_reader :error

    attr_reader :response
    private :response

    def initialize(response)
      @response = response
      @error    = Affirm::Responses::Error.new(response.body)
    end
  end
end
