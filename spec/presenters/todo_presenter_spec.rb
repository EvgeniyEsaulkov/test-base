require "rails_helper"

describe TodoPresenter do
  let(:todo) { build_stubbed(:todo, title: "Title", tags: tags) }  
  
  describe "#display_text" do
    subject(:todo_text) { described_class.new(todo).display_text }
  
    context "when Todo hasn't tags" do
      let(:tags) { nil }
      
      it "returns todo title" do
        expect(todo_text).to eq("Todo title")
      end
    end

    context "when Todo has tags" do
      let(:tags) { ["todo_tag", "some_tag"] }

      it "returns todo title with tags" do
        expect(todo_text).to eq("Todo title todo_tag, some_tag")
      end
    end

    context "when Todo has tags number more than allowed" do
      let(:tags) { ["first", "second", "third", "fourth", "fifth"] }
 
      it "returns title with first allowed tags" do
        expect(todo_text).to eq("Todo title first, second, third, fourth and_more...")
      end
    end
  end
end
