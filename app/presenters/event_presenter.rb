class EventPresenter
  def initialize(event)
    @event = event
  end

  def date
    case @event.date
    when Date.today
      "Today"
    when Date.yesterday
      "Yesterday"
    else
      @event.date.to_s
    end
  end
end
