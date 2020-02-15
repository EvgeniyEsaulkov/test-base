require "rails_helper"

describe Attachment do
  subject(:attachment) { build_stubbed(:attachment) }

  context "when file size is lesser than max attachment size" do
    it { is_expected.to be_valid }
  end

  context "when file size exceeds max attachment size" do
    before do
      attachment.attachment_size = Attachment::MAX_ATTACHMENT_SIZE + 1.byte
    end

    it { is_expected.not_to be_valid }

    it "has a validation error message" do
      attachment.validate

      expect(attachment.errors[:attachment]).to eq(["size is limited to 1GB per attachment"])
    end
  end
end
