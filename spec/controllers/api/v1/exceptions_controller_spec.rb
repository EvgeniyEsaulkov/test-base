require "rails_helper"

describe Api::V1::ExceptionsController do
  describe "#index" do
    include_context "current user signed in"

    subject(:exceptions) { assigns(:exceptions) }

    let(:exception1) { build_stubbed(:exception) }
    let(:exception2) { build_stubbed(:exception) }
    let(:project) { build_stubbed(:project) }

    context "when admin" do
      before do
        allow(project).to receive(:exceptions).and_return(ActiveRecordRelationStub.new(Exception, all_exceptions))
        allow(current_user).to receive(:admin?).and_return(true)
      end

      let(:all_exceptions) { [exception1, exception2] }

      it "returns all exceptions" do
        get :index, format: :json

        expect(project).to have_received(:exceptions)
        expect(current_user).to have_received(:admin?)
        expect(exceptions).to eq(all_exceptions)
      end
    end

    context "when user" do
      before do
        allow(project).to receive(:exceptions)
          .and_return(ActiveRecordRelationStub.new(Exception, [exception1], scopes: [:for_user]))
        allow(current_user).to receive(:admin?).and_return(false)
      end

      it "returns exceptions for current user only" do
        get :index, format: :json

        expect(project).to have_received(:exceptions)
        expect(current_user).to have_received(:admin?)
        expect(exceptions).to eq([exception1])
      end
    end
  end
end
