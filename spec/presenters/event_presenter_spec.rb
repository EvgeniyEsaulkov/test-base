require "rails_helper"

describe EventPresenter do
  describe "#date" do
    def presenter_date(date)
      event = instance_double("Event", date: date)
      described_class.new(event).date
    end
    
    it "returns correct date" do
      expect(presenter_date(Date.today)).to eql("Today")
      expect(presenter_date(Date.yesterday)).to eql("Yesterday")      
      expect(presenter_date(2.days.ago.to_date)).to eql(2.days.ago.to_date.to_s)      
      expect(presenter_date(Date.tomorrow)).to eql(Date.tomorrow.to_s)      
    end
  end
end
