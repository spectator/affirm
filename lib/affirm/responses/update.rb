module Affirm
  module Responses
    class Update
      include Virtus.model

      attribute :id,                    String
      attribute :order_id,              String
      attribute :shipping_carrier,      String
      attribute :shipping_confirmation, String
      attribute :created,               DateTime
      attribute :type,                  String
    end
  end
end
