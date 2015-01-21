module Affirm
  module Objects
    class Billing
      include Virtus.model

      attribute :name, Client
    end
  end
end
