# spec/controllers/segments_controller_spec.rb
require 'rails_helper'

RSpec.describe SegmentsController, type: :controller do
  let(:valid_attributes) {
    { name: 'Segment Name', description: 'Segment Description' }
  }

  let(:invalid_attributes) {
    { name: nil, description: nil }
  }

  describe "GET #index" do
    it "returns a success response" do
      segment = FactoryBot.create(:segment)
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      segment = FactoryBot.create(:segment)
      get :show, params: { id: segment.to_param }
      expect(response).to be_successful
    end

    it "returns not found for an invalid segment" do
      get :show, params: { id: 0 }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Segment" do
        expect {
          post :create, params: { segment: valid_attributes }
        }.to change(Segment, :count).by(1)
      end

      it "renders a JSON response with the new segment" do
        post :create, params: { segment: valid_attributes }
        expect(response).to have_http_status(:created)
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new segment" do
        post :create, params: { segment: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        { name: 'New Segment Name', description: 'New Segment Description' }
      }

      it "updates the requested segment" do
        segment = FactoryBot.create(:segment)
        put :update, params: { id: segment.to_param, segment: new_attributes }
        segment.reload
        expect(segment.name).to eq('New Segment Name')
        expect(segment.description).to eq('New Segment Description')
      end

      it "renders a JSON response with the segment" do
        segment = FactoryBot.create(:segment)
        put :update, params: { id: segment.to_param, segment: new_attributes }
        expect(response).to be_successful
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the segment" do
        segment = FactoryBot.create(:segment)
        put :update, params: { id: segment.to_param, segment: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested segment" do
      segment = FactoryBot.create(:segment)
      expect {
        delete :destroy, params: { id: segment.to_param }
      }.to change(Segment, :count).by(-1)
    end
  end
end
