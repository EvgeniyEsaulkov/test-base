require "rails_helper"

describe FindingAction do
  subject(:finding_action) { described_class.new(creator: creator) }

  let(:creator) { create(:user) }
  let(:updater) { create(:user) }

  describe "#notify_creator" do
    describe "when notifier is creator" do
      it "doesn't send notification" do
        expect(FindingActionNotifier).not_to receive(:send_creator_notification)

        finding_action.notify_creator(creator)
      end
    end

    describe "when notifier is not creator and can notify" do
      it "sends notification to creator" do
        allow(NotificationsManager).to receive(:allows_notifying?).with(updater).and_return(true)
        expect(FindingActionNotifier).to receive(:send_creator_notification)

        finding_action.notify_creator(updater)
      end
    end

    describe "when notifier is not creator and can't notify" do
      it "sends notification to creator" do
        allow(NotificationsManager).to receive(:allows_notifying?).with(updater).and_return(false)
        expect(FindingActionNotifier).not_to receive(:send_creator_notification)

        finding_action.notify_creator(updater)
      end
    end
  end
end
