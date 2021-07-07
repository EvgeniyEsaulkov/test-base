require "rails_helper"

shared_examples "a reviewer notification" do
  it "sends email to reviewer" do
    expect(email).to deliver_to("reviewer@email.me")
  end

  it "sends email with specified subject" do
    expect(email).to have_subject(email_subject)
  end
end

describe ReviewerMailer do
  let(:reviewer) { double("Reviewer", email: "reviewer@email.me", locale: 'en') }

  describe "#narrative_reivewer_notification" do
    let(:narrative) { double("Narrative") }

    it_behaves_like "a reviewer notification" do
      let(:email) { described_class.narrative_reviewer_notification(reviewer, narrative) }
      let(:email_subject) { "Narrative is assigned to you for review" }
    end
  end

  describe "#control_reviewer_notification" do
    let(:control) { double("Control") }

    it_behaves_like "a reviewer notification" do
      let(:email) { described_class.control_reviewer_notification(reviewer, control) }
      let(:email_subject) { "Control is assigned to you for review" }
    end
  end

  describe "#walkthrough_reviewer_notification" do
    let(:walkthrough) { double("Walkthrough") }

    it_behaves_like "a reviewer notification" do
      let(:email) { described_class.walkthrough_reviewer_notification(reviewer, walkthrough) }
      let(:email_subject) { "Walkthrough is assigned to you for review" }
    end
  end
end
