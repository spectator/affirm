module Affirm
  module Objects
    class Shipping
      include Virtus.model

      attribute :name,    Client
      attribute :address, Address
    end
  end
end
