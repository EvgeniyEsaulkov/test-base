class Risk
  attr_accessor :resolved_permanently, :resolved_until, :tags

  def tag_list
    tags.to_s.split(",").map(&:strip).map(&:presence).compact
  end

  def resolve_for=(period)
    case period
    when "one_month"
      resolve_until(1.month.from_now)
    when "one_year"
      resolve_until(1.year.from_now)
    when "permanently"
      self.resolved_until = nil
      self.resolved_permanently = true
    end
  end

  private

  def resolve_until(date)
    self.resolved_until = date
    self.resolved_permanently = false
  end
end
