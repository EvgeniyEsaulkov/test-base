require "rails_helper"

describe BatchSectionClone do
  describe ".clone" do
    subject(:batch_clone) { described_class.clone(sections, target) }

    let(:section_clone_service) { instance_double("SectionClone") }
    let(:sections) { create_list(:section, 3) }
    let(:target) { create(:target) }

    before do
      allow(SectionClone).to receive(:new).and_return(:section_clone_service)
    end

    it "calls section clone service" do
      expect(section_clone_service).to receive(:clone).exactly(sections.size).times

      batch_clone
    end
  end
end
