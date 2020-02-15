class Project
  attr_reader :completion_percentage

  def completion_percentage=(percentage)
    percentage = percentage.to_i

    @completion_percentage = case
    when percentage > 100
      100
    when percentage < 0
      0
    else
      percentage
    end
  end
end
