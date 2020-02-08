require "rails_helper"

describe Attachment do
  describe "#editable?" do
    context "when attachment has permitted type" do
      subject(:attachment) { described_class.new(Attachment::MS_OFFICE_TYPES.sample) }

      it { is_expected.to be_editable }
    end

    context "when attachment has non-permitted type" do
      subject(:attachment) { described_class.new("application/zip") }

      it { is_expected.not_to be_editable }
    end
  end

  describe "#locked?" do
    context "when locked_until attribute is not defined" do
      subject(:attachment) { described_class.new("application/msword") }

      it { is_expected.not_to be_locked }
    end

    context "when locked_until attribute is in past" do
      subject(:attachment) { described_class.new("application/msword", 1.minute.ago) }

      it { is_expected.not_to be_locked }
    end

    context "when locked_until attribute is equal to current time" do
      before do
        travel_to Time.zone.local(2020, 1, 8)
      end

      after do
        travel_back
      end

      subject(:attachment) { described_class.new("application/msword", Time.zone.local(2020, 1, 8)) }

      it { is_expected.not_to be_locked }
    end

    context "when locked_until attribute is in future" do
      subject(:attachment) { described_class.new("application/msword", 1.minute.from_now) }

      it { is_expected.to be_locked }
    end
  end
end
