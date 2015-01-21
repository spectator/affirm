module Affirm
  module Responses
    class Error
      include Virtus.model

      attribute :status_code, Integer
      attribute :type,        String
      attribute :code,        String
      attribute :message,     String
      attribute :field,       String
    end
  end
end
