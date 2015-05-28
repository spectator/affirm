RSpec.shared_examples "a charge object interface" do
  %w(
    id
    status
    user_id
    currency
    amount
    auth_hold
    payable
    pending
    void
    under_dispute
  ).each do |method|
    it method do
      expect(subject.public_send(method)).to eq(body[method])
    end
  end

  it "created" do
    expect(
      to_seconds(subject.created)
    ).to eq(to_seconds(body["created"]))
  end

  it "expires" do
    expect(
      to_seconds(subject.expires)
    ).to eq(to_seconds(body["expires"]))
  end

  %w(
    id
    transaction_id
    currency
    amount
    type
  ).each do |method|
    it "events.#{method}" do
      expect(
        subject.events.first.public_send(method)
      ).to eq(body["events"].first[method])
    end
  end

  it "events.created" do
    expect(
      to_seconds(subject.events.first.created)
    ).to eq(to_seconds(body["events"].first["created"]))
  end

  %w(
    currency
    tax_amount
    shipping_amount
    total
  ).each do |method|
    it "details.#{method}" do
      expect(
        subject.details.public_send(method)
      ).to eq(body["details"][method])
    end
  end

  %w(
    discount_display_name
    discount_amount
  ).each do |method|
    it "details.discounts.#{method}" do
      expect(
        subject.details.discounts["discount_name"].public_send(method)
      ).to eq(body["details"]["discounts"]["discount_name"][method])
    end
  end

  %w(
    sku
    display_name
    unit_price
    qty
    item_type
    item_url
    item_image_url
  ).each do |method|
    it "details.items.#{method}" do
      expect(
        subject.details.items["ABC-123"].public_send(method)
      ).to eq(body["details"]["items"]["ABC-123"][method])
    end
  end

  %w(
    full
    first
    last
    middle
  ).each do |method|
    it "details.billing.name.#{method}" do
      expect(
        subject.details.billing.name.public_send(method)
      ).to eq(body["details"]["billing"]["name"][method])
    end
  end

  %w(
    full
    first
    last
    middle
  ).each do |method|
    it "details.shipping.name.#{method}" do
      expect(
        subject.details.shipping.name.public_send(method)
      ).to eq(body["details"]["shipping"]["name"][method])
    end
  end

  %w(
    line1
    line2
    city
    state
    zipcode
    country
  ).each do |method|
    it "details.shipping.address.#{method}" do
      expect(
        subject.details.shipping.address.public_send(method)
      ).to eq(body["details"]["shipping"]["address"][method])
    end
  end
end
