require "rails_helper"

describe FindingAction do
  subject(:finding_action) { create(:finding_action) }

  let(:updater) { build_stubbed(:user) }

  describe "#notify_creator" do
    context "when notifier is creator" do
      it "doesn't send notification" do
        expect(FindingActionNotifier).not_to receive(:send_creator_notification)

        finding_action.notify_creator(finding_action.creator)
      end
    end

    context "when notifier is not creator" do
      it "sends notification to creator" do
        expect(FindingActionNotifier).to receive(:send_creator_notification)

        finding_action.notify_creator(updater)
      end
    end
  end
end
