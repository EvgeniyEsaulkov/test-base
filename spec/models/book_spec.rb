require "rails_helper"

describe Book do
  before { book.filename = filename }

  let(:book) { described_class.new }
  let(:filename) { "Very-interesting-book.txt" }

  describe "#file_url" do
    subject { book.file_url }

    let(:path_prefix) { filename[0..1].downcase }

    it { is_expected.to start_with("/system/") }
    it { is_expected.to end_with(filename) }

    it { is_expected.to include(path_prefix) }
  end

  describe "#delete_file" do
    it "clears filename" do
      expect { book.delete_file }.to change { book.filename }.from(filename).to(nil)
    end

    it "sets file_destroyed_at attribute" do
      expect(book.file_destroyed_at).to be_nil

      book.delete_file

      expect(book.file_destroyed_at).not_to be_nil
    end
  end
end
