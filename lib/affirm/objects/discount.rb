module Affirm
  module Objects
    class Discount
      include Virtus.model

      attribute :discount_display_name, String
      attribute :discount_amount,       Integer
    end
  end
end
