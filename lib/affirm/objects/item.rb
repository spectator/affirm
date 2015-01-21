module Affirm
  module Objects
    class Item
      include Virtus.model

      attribute :sku,            String
      attribute :display_name,   String
      attribute :unit_price,     Integer
      attribute :qty,            Integer
      attribute :item_type,      String
      attribute :item_url,       String
      attribute :item_image_url, String
    end
  end
end
