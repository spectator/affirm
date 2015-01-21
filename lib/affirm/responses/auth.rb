module Affirm
  module Responses
    class Auth
      include Virtus.model

      attribute :id,            String
      attribute :user_id,       String
      attribute :currency,      String
      attribute :amount,        Integer
      attribute :auth_hold,     Integer
      attribute :payable,       Integer
      attribute :pending,       Boolean
      attribute :void,          Boolean
      attribute :under_dispute, Boolean
      attribute :events,        Array[Objects::Event]
      attribute :details,       Objects::Order
      attribute :created,       DateTime
      attribute :expires,       DateTime
    end
  end
end
