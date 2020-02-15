class ReviewerMailer < ApplicationMailer
  def narrative_reviewer_notification(reviewer, narrative)
    I18n.with_locale(reviewer.locale) do
      @narrative = narrative

      mail to: reviewer.email,
        subject: "Narrative is assigned to you for review"
    end
  end

  def control_reviewer_notification(reviewer, control)
    I18n.with_locale(reviewer.locale) do
      @control = control

      mail to: reviewer.email,
        subject: "Control is assigned to you for review"
    end
  end


  def walkthrough_reviewer_notification(reviewer, walkthrough)
    I18n.with_locale(reviewer.locale) do
      @walkthrough = walkthrough

      mail to: reviewer.email,
        subject: "Walkthrough is assigned to you for review"
    end
  end
end
