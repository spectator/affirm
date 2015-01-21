module Affirm
  module Objects
    class Order
      include Virtus.model

      attribute :currency,        Integer
      attribute :tax_amount,      Integer
      attribute :shipping_amount, Integer
      attribute :total,           Integer
      attribute :discounts,       Hash[String => Discount]
      attribute :items,           Hash[String => Item]
      attribute :billing,         Billing
      attribute :shipping,        Shipping
    end
  end
end
