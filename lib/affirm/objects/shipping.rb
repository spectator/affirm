module Affirm
  module Objects
    class Shipping
      include Virtus.model

      attribute :name,    Contact
      attribute :address, Address
    end
  end
end
