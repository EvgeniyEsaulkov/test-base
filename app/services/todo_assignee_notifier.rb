class TodoAssigneeNotifier
  def self.notify(todo)
    if NotificationManager.allows_notifying_membership?(todo.executor)
      TodoMailer.todo_notification(todo)
    end

    PushNotification.deliver("todo_assign", todo.executor, todo)
  end
end
