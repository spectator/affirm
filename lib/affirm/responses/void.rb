module Affirm
  module Responses
    class Void
      include Virtus.model

      attribute :id,             String
      attribute :transaction_id, String
      attribute :created,        DateTime
      attribute :type,           String
    end
  end
end
