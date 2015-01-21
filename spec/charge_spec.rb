require "helper"

RSpec.describe Affirm::Charge do
  let(:failed_response) { double(:response, success?: false, body: Hash.new) }

  context "authorize" do
    context "with failed response" do
      subject { described_class }

      before do
        expect(Affirm::Client).to receive(:request)
          .with(:post, "charges", checkout_token: "ABC")
          .and_return(failed_response)
      end

      it "returns failure object" do
        expect(
          subject.authorize("ABC")
        ).to be_an_instance_of(Affirm::FailureResult)
      end
    end

    context "with successful response" do
      subject { described_class.authorize("ABC") }

      let(:body) do
        JSON.load(
          File.read(File.expand_path("../fixtures/auth.json", __FILE__))
        )
      end

      let(:successful_response) do
        double(:response, success?: true, body: body)
      end

      before do
        expect(Affirm::Client).to receive(:request)
          .with(:post, "charges", checkout_token: "ABC")
          .and_return(successful_response)
      end

      %w(
        id
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
  end

  context "capture" do
    context "with failed response" do
      subject { described_class }

      before do
        expect(Affirm::Client).to receive(:request)
          .with(:post, "charges/1/capture")
          .and_return(failed_response)
      end

      it "returns failure object" do
        expect(
          subject.capture(1)
        ).to be_an_instance_of(Affirm::FailureResult)
      end
    end

    context "with successful response" do
      subject { described_class.capture(1) }

      let(:body) do
        {
          "id"             => "ABC-111",
          "transaction_id" => "XYZ-999",
          "currency"       => "USD",
          "amount"         => 100,
          "fee"            => 10,
          "created"        => Time.local(2015, 1, 1),
          "type"           => "capture"
        }
      end

      let(:successful_response) do
        double(:response, success?: true, body: body)
      end

      before do
        expect(Affirm::Client).to receive(:request)
          .with(:post, "charges/1/capture")
          .and_return(successful_response)
      end

      %w(
        id
        transaction_id
        currency
        amount
        fee
        type
      ).each do |method|
        it method do
          expect(subject.public_send(method)).to eq(body[method])
        end
      end

      it "created" do
        expect(to_seconds(subject.created)).to eq(to_seconds(body["created"]))
      end
    end
  end

  context "void" do
    context "with failed response" do
      subject { described_class }

      before do
        expect(Affirm::Client).to receive(:request)
          .with(:post, "charges/1/void")
          .and_return(failed_response)
      end

      it "returns failure object" do
        expect(
          subject.void(1)
        ).to be_an_instance_of(Affirm::FailureResult)
      end
    end

    context "with successful response" do
      subject { described_class.void(1) }

      let(:body) do
        {
          "id"             => "ABC-111",
          "transaction_id" => "XYZ-999",
          "created"        => Time.local(2015, 1, 1),
          "type"           => "void"
        }
      end

      let(:successful_response) do
        double(:response, success?: true, body: body)
      end

      before do
        expect(Affirm::Client).to receive(:request)
          .with(:post, "charges/1/void")
          .and_return(successful_response)
      end

      %w(
        id
        transaction_id
        type
      ).each do |method|
        it method do
          expect(subject.public_send(method)).to eq(body[method])
        end
      end

      it "created" do
        expect(to_seconds(subject.created)).to eq(to_seconds(body["created"]))
      end
    end
  end

  context "refund" do
    context "with failed response" do
      subject { described_class }

      before do
        expect(Affirm::Client).to receive(:request)
          .with(:post, "charges/1/refund", amount: 50)
          .and_return(failed_response)
      end

      it "returns failure object" do
        expect(
          subject.refund(1, amount: 50)
        ).to be_an_instance_of(Affirm::FailureResult)
      end
    end

    context "with successful response" do
      subject { described_class.refund(1, amount: 50) }

      let(:body) do
        {
          "id"             => "ABC-111",
          "transaction_id" => "XYZ-999",
          "amount"         => 50,
          "fee_refunded"   => 0,
          "created"        => Time.local(2015, 1, 1),
          "type"           => "refund"
        }
      end

      let(:successful_response) do
        double(:response, success?: true, body: body)
      end

      before do
        expect(Affirm::Client).to receive(:request)
          .with(:post, "charges/1/refund", amount: 50)
          .and_return(successful_response)
      end

      %w(
        id
        transaction_id
        amount
        fee_refunded
        type
      ).each do |method|
        it method do
          expect(subject.public_send(method)).to eq(body[method])
        end
      end

      it "created" do
        expect(to_seconds(subject.created)).to eq(to_seconds(body["created"]))
      end
    end
  end

  context "update" do
    context "with failed response" do
      subject { described_class }

      before do
        expect(Affirm::Client).to receive(:request)
          .with(:post, "charges/1/update",
            order_id: "XYZ-007",
            shipping_carrier: "FedEx",
            shipping_confirmation: "1ZX007")
          .and_return(failed_response)
      end

      it "returns failure object" do
        expect(
          subject.update(1,
            order_id: "XYZ-007",
            shipping_carrier: "FedEx",
            shipping_confirmation: "1ZX007"
          )
        ).to be_an_instance_of(Affirm::FailureResult)
      end
    end

    context "with successful response" do
      subject do
        described_class.update(1,
          order_id: "XYZ-007",
          shipping_carrier: "FedEx",
          shipping_confirmation: "1ZX007"
        )
      end

      let(:body) do
        {
          "id"                    => "ABC-007",
          "order_id"              => "XYZ-007",
          "shipping_carrier"      => "FedEx",
          "shipping_confirmation" => "1ZX007",
          "created"               => Time.local(2015, 1, 1),
          "type"                  => "update"
        }
      end

      let(:successful_response) do
        double(:response, success?: true, body: body)
      end

      before do
        expect(Affirm::Client).to receive(:request)
          .with(:post, "charges/1/update",
            order_id: "XYZ-007",
            shipping_carrier: "FedEx",
            shipping_confirmation: "1ZX007"
          )
          .and_return(successful_response)
      end

      %w(
        id
        order_id
        shipping_carrier
        shipping_confirmation
        type
      ).each do |method|
        it method do
          expect(subject.public_send(method)).to eq(body[method])
        end
      end

      it "created" do
        expect(to_seconds(subject.created)).to eq(to_seconds(body["created"]))
      end
    end
  end
end
