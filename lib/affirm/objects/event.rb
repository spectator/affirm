module Affirm
  module Objects
    class Event
      include Virtus.model

      attribute :id,             String
      attribute :transaction_id, String
      attribute :currency,       String
      attribute :amount,         Integer
      attribute :type,           String
      attribute :created,        DateTime
    end
  end
end
