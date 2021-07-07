require "rails_helper"

describe Assessment do
  describe "#score" do
    subject(:assessment_score) { described_class.new(risk, scale).score }

    context "when neither risk impact nor likelihood is on the scale" do
      let(:risk) { instance_double("Risk", impact: 2, likelihood: 0.5) }
      let(:scale) { instance_double("Scale", impacts: [1, 3], likelihoods: [0.3, 0.7]) }

      it { is_expected.to eq(1) }
    end

    context "when risk impact is on the scale but likelihood is not" do
      let(:risk) { instance_double("Risk", impact: 3, likelihood: 0.5) }
      let(:scale) { instance_double("Scale", impacts: [1, 3], likelihoods: [0.3, 0.7]) }
      let(:index_of_risk_impact_on_the_scale) { 2 }

      it { is_expected.to eq(index_of_risk_impact_on_the_scale) }
    end

    context "when risk likelihood is on the scale but impact is not" do
      let(:risk) { instance_double("Risk", impact: 2, likelihood: 0.5) }
      let(:scale) { instance_double("Scale", impacts: [1, 3], likelihoods: [0.3, 0.5]) }
      let(:index_of_risk_likelihood_on_the_scale) { 2 }

      it { is_expected.to eq(index_of_risk_likelihood_on_the_scale) }
    end

    context "when both risk impact and likelihood is on the scale" do
      let(:risk) { instance_double("Risk", impact: 2, likelihood: 0.5) }
      let(:scale) { instance_double("Scale", impacts: [1, 2], likelihoods: [0.3, 0.5]) }
      let(:expected_result) { 4 }

      it "is calculated depending on indexes of risk impact and risk likelihood" do
        expect(assessment_score).to eq(expected_result)
      end
    end
  end
end
