require "rails_helper"

describe Project do
  describe "#completion_percentage=" do
    MIN_PERCENTAGE = 0
    MAX_PERCENTAGE = 100
    
    def completion_percentage(percentage)
      project = described_class.new
      project.completion_percentage = percentage
      project.completion_percentage
    end
    
    it "calculates values between 0 and 100" do
      expect(completion_percentage(-1)).to eql(0)
      expect(completion_percentage(0)).to eql(0)
      expect(completion_percentage(100)).to eql(100)
      expect(completion_percentage(101)).to eql(100)      
    end
  end
end
