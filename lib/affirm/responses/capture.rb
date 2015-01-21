module Affirm
  module Responses
    class Capture
      include Virtus.model

      attribute :id,             String
      attribute :transaction_id, String
      attribute :currency,       String
      attribute :amount,         Integer
      attribute :fee,            Integer
      attribute :created,        DateTime
      attribute :type,           String
    end
  end
end
