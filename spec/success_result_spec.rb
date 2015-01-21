require "helper"

RSpec.describe Affirm::SuccessResult do
  let(:object) { double(:object, id: 1, amount: 500, void: false) }

  subject { described_class.new(object) }

  it "should be successful" do
    expect(subject).to be_success
  end

  it "should have id" do
    expect(subject.id).to eq(object.id)
  end

  it "should have amount" do
    expect(subject.amount).to eq(object.amount)
  end

  it "should not be voided" do
    expect(subject.void).to be_falsey
  end

  it "should raise no method error on missing method" do
    expect { subject.does_not_exist }.to raise_error(NoMethodError)
  end

  it "should not respond to missing method" do
    expect(subject).not_to respond_to(:does_not_exist)
  end
end
