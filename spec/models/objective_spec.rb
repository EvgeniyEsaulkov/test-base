require "rails_helper"

describe Objective do
  describe "#locked?" do
    subject(:objective) do
      objective = described_class.new
      objective.assign_attributes(locked_by: "Joe Dow", lock_status: 2)
      objective
    end

    describe "when locked_by is present" do
      describe "when lock status is locked" do # rubocop: disable RSpec/NestedGroups
        it "returns true" do
          expect(objective.locked?).to be_truthy
        end
      end

      describe "when lock status is unlocked" do # rubocop: disable RSpec/NestedGroups
        before do
          objective.lock_status = 0
        end

        it "returns false" do
          expect(objective.locked?).to be_falsey
        end
      end

      describe "when lock status is uploading" do # rubocop: disable RSpec/NestedGroups
        before do
          objective.lock_status = 1
        end

        it "returns true" do
          expect(objective.locked?).to be_truthy
        end
      end
    end

    describe "when locked_by is not present" do
      before do
        objective.locked_by = nil
      end

      it "returns false" do
        expect(objective.locked?).to be_falsey
      end
    end
  end

  describe "#release_lock" do
    subject(:objective) do
      obj = described_class.new
      obj.assign_attributes(locked_by: "Joe Dow", locked_on_name: "FooBar", locked_on_id: 1234, lock_status: 2)
      obj
    end

    it "set lock status to unlocked" do
      expect { objective.release_lock }.to change { objective.lock_status }.from(2).to(0)
    end

    it "nullifies all locked_* attributes" do
      objective.release_lock

      expect(objective.locked_by).to be_nil
      expect(objective.locked_on_name).to be_nil
      expect(objective.locked_on_id).to be_nil
    end
  end
end
