require "rails_helper"

describe Objective do
  describe "#locked?" do
    subject(:objective) do
      objective = described_class.new
      objective.assign_attributes(locked_by: "Joe Dow", lock_status: Objective::LOCK_STATUSES[:locked])
      objective
    end

    context "when locked_by is present" do
      context "when lock status is locked" do # rubocop: disable RSpec/NestedGroups
        it { is_expected.to be_locked }
      end

      context "when lock status is unlocked" do # rubocop: disable RSpec/NestedGroups
        before do
          objective.lock_status =  Objective::LOCK_STATUSES[:unlocked]
        end

        it { is_expected.not_to be_locked }
      end

      context "when lock status is uploading" do # rubocop: disable RSpec/NestedGroups
        before do
          objective.lock_status =  Objective::LOCK_STATUSES[:uploading]
        end

        it { is_expected.to be_locked }
      end
    end

    context "when locked_by is not present" do
      before do
        objective.locked_by = nil
      end

      it { is_expected.not_to be_locked }
    end
  end

  describe "#release_lock" do
    subject(:objective) do
      obj = described_class.new
      obj.assign_attributes(locked_by: "Joe Dow", locked_on_name: "FooBar", locked_on_id: 1234,
                            lock_status:  Objective::LOCK_STATUSES[:locked])
      obj
    end

    it "set lock status to unlocked" do
      expect { objective.release_lock }.to change { objective.lock_status }
        .from(Objective::LOCK_STATUSES[:locked]).to(Objective::LOCK_STATUSES[:unlocked])
    end

    it "nullifies all locked_* attributes" do
      objective.release_lock

      expect(objective.locked_by).to be_nil
      expect(objective.locked_on_name).to be_nil
      expect(objective.locked_on_id).to be_nil
    end
  end
end
