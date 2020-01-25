require "rails_helper"

describe TestUser do
  let(:user) { described_class.new }
  let(:dbl) { instance_double("TestExample") }

  describe "#date_format" do
    before do
      allow(TestExample).to receive(:new).and_return(dbl)
    end

    context "when this method from superclass returns a value" do
      before do
        allow(dbl).to receive(:date_format).and_return("%m-%d-%Y")
      end

      it "returns value from superclass" do
        expect(user.date_format).to eq("%m-%d-%Y")
      end
    end

    context "when this method from superclass returns nil" do
      before do
        allow(dbl).to receive(:date_format)
      end

      it "returns expected value" do
        expect(user.date_format).to eq("%d.%m.%Y")
      end
    end
  end

  describe "#validate" do
    subject(:validate) { user.validate }

    it "set access token" do
      expect(user.access_token).to be_nil

      validate
      expect(user.access_token).not_to be_nil
    end

    it "set access token once" do
      validate

      expect { validate }.not_to change { user.access_token }
    end
  end
end
