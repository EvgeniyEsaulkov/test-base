require "rails_helper"

shared_examples "set resolved_* attributes" do
  it "sets resolved_until attribute to specified date" do
    risk.resolve_for = period
    expect(risk.resolved_until - resolved_date).to be <= 1
  end

  it "clears resolved_permanently flag" do
    risk.resolve_for = period
    expect(risk.resolved_permanently).to be_falsey
  end
end

describe Risk do
  let(:risk) { described_class.new }

  describe "#tag_list" do
    before { risk.tags = tags }

    subject(:tag_list) { risk.tag_list }

    let(:tags) { "foo, bar , ,  foobar" }
    let(:tag_array) { %w[foo bar foobar] }

    it "returns array of tags" do
      expect(tag_list).to eq(tag_array)
    end
  end

  describe "#resolve_for=" do
    context "when period is one month" do
      it_behaves_like "set resolved_* attributes" do
        let(:period) { "one_month" }
        let(:resolved_date) { 1.month.from_now }
      end
    end

    context "when period is one year" do
      it_behaves_like "set resolved_* attributes" do
        let(:period) { "one_year" }
        let(:resolved_date) { 1.year.from_now }
      end
    end

    context "when period is permanently" do
      before do
        risk.resolved_until = resolved_date
        risk.resolved_permanently = false
      end

      subject(:resolve_permanently) { risk.resolve_for = period }

      let(:resolved_date) { 1.month.from_now }
      let(:period) { "permanently" }

      it "clears resolved_until attribute" do
        expect { resolve_permanently }.to change { risk.resolved_until }.from(resolved_date).to(nil)
      end

      it "sets resolved_permanently flag" do
        expect { resolve_permanently }.to change { risk.resolved_permanently }.from(false).to(true)
      end
    end

    context "when period is something wrong" do
      before do
        risk.resolved_until = 1.month.from_now
        risk.resolved_permanently = false
      end

      subject(:resolve_for_wrong_period) { risk.resolve_for = period }

      let(:period) { "two_years" }

      it "doesn't change resolved_* attributes" do
        expect { resolve_for_wrong_period }.not_to change { risk.resolved_until }
        expect { resolve_for_wrong_period }.not_to change { risk.resolved_permanently }
      end
    end
  end
end
