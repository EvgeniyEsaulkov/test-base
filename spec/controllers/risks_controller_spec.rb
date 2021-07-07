require "rails_helper"

describe RisksController do
  describe "#update_from_origin" do
    let(:source_trackable_updater) { instance_double("SourceTrackableUpdater") }

    before do
      allow(SourceTrackableUpdater).to receive(:new).and_return(source_trackable_updater)
    end

    it "updates trackable resource from origin" do
      expect(source_trackable_updater).to receive(:update_from_origin)

      patch :update_from_origin
    end
  end
end
