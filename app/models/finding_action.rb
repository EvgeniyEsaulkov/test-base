class FindingAction
  belongs_to :creator

  def notify_creator(updater)
    FindingActionNotifier.send_creator_notification(self) if should_notify_creator?(updater)
  end

  private

  def should_notify_creator?(updater)
    updater != creator && NotificationsManager.allows_notifying?(updater)
  end
end
