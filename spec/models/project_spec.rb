require "rails_helper"

describe Project do
  describe "#completion_percentage=" do
    MIN_PERCENTAGE = 0
    MAX_PERCENTAGE = 100

    let(:project) { described_class.new }

    subject(:completion_percentage) { project.completion_percentage }

    before { project.completion_percentage = assigned_value }

    context "when assigned valued is negative" do
      let(:assigned_value) { -1 }

      it { is_expected.to eq(MIN_PERCENTAGE) }
    end

    context "when assigned value is more than max allowed value" do
      let(:assigned_value) { 101 }

      it { is_expected.to eq(MAX_PERCENTAGE) }
    end

    context "when assigned value is between allowed values" do
      let(:assigned_value) { rand(101) }

      it { is_expected.to eq(assigned_value) }
    end
  end
end
