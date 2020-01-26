require "rails_helper"

describe TodoAssigneeNotifier do
  describe ".notify" do
    subject(:notify) { described_class.notify(todo) }

    let(:todo) { create(:todo) }

    context "when executor has notify permission" do
      before do
        allow(NotificationManager).to receive(:allows_notifying_membership)
          .with(todo.executor).and_return(true)
      end

      it "sends email notification" do
        expect(TodoMailer).to receive(:todo_notification).with(todo)

        notify
      end
    end

    context "when executor hasn't notify permission" do
      before do
        allow(NotificationManager).to receive(:allows_notifying_membership)
          .with(todo.executor).and_return(false)
      end

      it "doesn't send email notification" do
        expect(TodoMailer).not_to receive(:todo_notification)

        notify
      end
    end

    it "sends push notification" do
      expect(PushNotification).to receive(:deliver).with("todo_assign", todo.executor, todo)

      notify
    end
  end
end
