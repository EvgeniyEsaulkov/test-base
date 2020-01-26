require "rails_helper"

describe CarwashLocator do
  describe ".nearest" do
    subject(:nearest) { described_class.nearest(coordinates) }

    before { create(:carwash, latitude: 55.5, longitude: 37.5) }

    context "when there are some carwashes nearby" do
      let(:coordinates) { { latitude: 55.75, longitude: 37.65 } }

      it "returns list of carwashes" do
        expect(nearest).to be_array
        expect(nearest.size).to eq(1)
        expect(nearest.first).to be_a(Carwash)
      end
    end

    context "when there are no carwashes nearby" do
      let(:coordinates) { { latitude: 90, longitude: 0 } }

      it "returns empty list" do
        expect(nearest).to eq([])
      end
    end
  end
end
