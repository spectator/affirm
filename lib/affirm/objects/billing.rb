module Affirm
  module Objects
    class Billing
      include Virtus.model

      attribute :name, Contact
    end
  end
end
