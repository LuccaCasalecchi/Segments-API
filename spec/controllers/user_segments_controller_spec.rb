# spec/controllers/user_segments_controller_spec.rb
require 'rails_helper'

RSpec.describe UserSegmentsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:segment) { FactoryBot.create(:segment) }

  describe "POST #create" do
    context "with valid params" do
      it "creates a new UserSegment" do
        expect {
          post :create, params: { user_id: user.id, segment_id: segment.id }
        }.to change(UserSegment, :count).by(1)
      end

      it "returns a created status" do
        post :create, params: { user_id: user.id, segment_id: segment.id }
        expect(response).to have_http_status(:created)
      end
    end

    context "with invalid params" do
      it "returns a not found status for invalid user" do
        post :create, params: { user_id: 0, segment_id: segment.id }
        expect(response).to have_http_status(:not_found)
      end

      it "returns a not found status for invalid segment" do
        post :create, params: { user_id: user.id, segment_id: 0 }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested UserSegment" do
      user.segments << segment
      user_segment = UserSegment.find_by(user: user, segment: segment)

      expect {
        delete :destroy, params: { user_id: user.id, id: segment.id }
      }.to change(UserSegment, :count).by(-1)
    end
  end

  describe "GET #index" do
    it "returns a success response" do
      user.segments << segment
      get :index, params: { user_id: user.id }
      expect(response).to be_successful
    end
  end
end
