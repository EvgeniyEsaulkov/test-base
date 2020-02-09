require "rails_helper"

describe EventPresenter do
  describe "#date" do
    subject(:presenter_date) { described_class.new(event).date }

    context "when the event should happen today" do
      let(:event) { instance_double("Event", date: Date.today) }

      it { is_expected.to eq("Today") }
    end

    context "when the event was supposed to happen yesterday" do
      let(:event) { instance_double("Event", date: Date.yesterday) }

      it { is_expected.to eq("Yesterday") }
    end

    context "when the event was supposed to happen before yesterday" do
      let(:event) { instance_double("Event", date: event_date) }
      let(:event_date) { 2.days.ago.to_date }
      let(:date_string) { event_date.to_s }

      it { is_expected.to eq(date_string) }
    end

    context "when the event should happen in the future" do
      let(:event) { instance_double("Event", date: event_date) }
      let(:event_date) { Date.tomorrow }
      let(:date_string) { event_date.to_s }

      it { is_expected.to eq(date_string) }
    end
  end
end
