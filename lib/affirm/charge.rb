module Affirm
  module Charge
    extend self

    def authorize(token)
      respond Client.request(:post, "charges", checkout_token: token)
    end

    def find(charge_id)
      respond Client.request(:get, "charges/#{charge_id}")
    end

    def capture(charge_id)
      respond Client.request(:post, "charges/#{charge_id}/capture")
    end

    def void(charge_id)
      respond Client.request(:post, "charges/#{charge_id}/void")
    end

    def refund(charge_id, amount:)
      respond Client.request(:post, "charges/#{charge_id}/refund", amount: amount)
    end

    def update(charge_id, **updates)
      respond Client.request(:post, "charges/#{charge_id}/update", updates)
    end

    private

    def respond(response)
      return FailureResult.new(response) unless response.success?

      type  = response.body["type"]
      klass = case type
      when *%w(capture void refund update)
        Object.const_get("Affirm::Responses::#{type.capitalize}")
      else
        Affirm::Responses::Auth
      end

      SuccessResult.new(klass.new(response.body))
    end
  end
end
