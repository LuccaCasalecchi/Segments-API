# spec/controllers/tags_controller_spec.rb
require 'rails_helper'

RSpec.describe TagsController, type: :controller do
  let(:valid_attributes) {
    { name: 'Tag Name' }
  }

  let(:invalid_attributes) {
    { name: nil }
  }

  describe "GET #index" do
    it "returns a success response" do
      FactoryBot.create(:tag)
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      tag = FactoryBot.create(:tag)
      get :show, params: { id: tag.to_param }
      expect(response).to be_successful
    end

    it "returns not found for an invalid tag" do
      get :show, params: { id: 0 }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Tag" do
        expect {
          post :create, params: { tag: valid_attributes }
        }.to change(Tag, :count).by(1)
      end

      it "renders a JSON response with the new tag" do
        post :create, params: { tag: valid_attributes }
        expect(response).to have_http_status(:created)
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new tag" do
        post :create, params: { tag: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        { name: 'New Tag Name' }
      }

      it "updates the requested tag" do
        tag = FactoryBot.create(:tag)
        put :update, params: { id: tag.to_param, tag: new_attributes }
        tag.reload
        expect(tag.name).to eq('New Tag Name')
      end

      it "renders a JSON response with the tag" do
        tag = FactoryBot.create(:tag)
        put :update, params: { id: tag.to_param, tag: new_attributes }
        expect(response).to be_successful
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the tag" do
        tag = FactoryBot.create(:tag)
        put :update, params: { id: tag.to_param, tag: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested tag" do
      tag = FactoryBot.create(:tag)
      expect {
        delete :destroy, params: { id: tag.to_param }
      }.to change(Tag, :count).by(-1)
    end
  end
end
