module Affirm
  module Objects
    class Address
      include Virtus.model

      attribute :line1,   String
      attribute :line2,   String
      attribute :city,    String
      attribute :state,   String
      attribute :zipcode, String
      attribute :country, String
    end
  end
end
