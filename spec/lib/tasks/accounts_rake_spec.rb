require "rails_helper"

describe "accounts:remove_invalid" do # rubocop:disable RSpec/DescribeClass
  include_context "rake"

  before do
    let(:remove_invalid_accounts) { instance_double("RemoveInvalidAccounts") }

    it "calls service that removes invalid accounts" do
      expect(RemoveInvalidAccounts).to receive(:new).and_return(remove_invalid_accounts)
      expect(remove_invalid_accounts).to receive(:perform)

      rake_task.invoke
    end
  end
end
