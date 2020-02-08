require "rails_helper"

describe TodoPresenter do
  describe "#display_text" do
    context "when Todo hasn't tags" do
      let(:todo) { build_stubbed(:todo, title: todo_title) }
      let(:todo_title) { "Todo title" }

      subject(:todo_text) { described_class.new(todo).display_text }

      it { is_expected.to eq(todo_title) }
    end

    context "when Todo has tags" do
      let(:todo) { build_stubbed(:todo, title: "Todo title", tags: ["todo_tag", "some_tag"]) }
      let(:title_with_tags) { "Todo title todo_tag, some_tag" }

      subject(:todo_text) { described_class.new(todo).display_text }

      it { is_expected.to eq(title_with_tags) }
    end

    context "when Todo has tags number more than allowed" do
      let(:todo) do
        build_stubbed(:todo, title: "Todo title", tags: ["first", "second", "third", "fourth", "fifth"])
      end
      let(:title_with_first_allowed_tags) { "Todo title first, second, third, fourth and_more..." }

      subject(:todo_text) { described_class.new(todo).display_text }

      it { is_expected.to eq(title_with_first_allowed_tags) }
    end
  end
end
