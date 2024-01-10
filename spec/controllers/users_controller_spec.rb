require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:valid_attributes) {
    {
      first_name: "Jane",
      last_name: "Doe",
      email: "jane.doe@example.com",
      birth_date: "2000-01-01",
      admission_date: "2022-01-01",
      is_active: true,
      sex: "F",
      last_sign_in_at: Time.current
    }
  }

  let(:invalid_attributes) {
    { first_name: nil }
  }

  describe "GET #index" do
    it "returns a success response" do
      user = FactoryBot.create(:user)
      get :index
      expect(response).to be_successful
      expect(json.size).to eq(1)
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      user = FactoryBot.create(:user)
      get :show, params: { id: user.to_param }
      expect(response).to be_successful
    end

    it "returns not found for an invalid user" do
      get :show, params: { id: 0 }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new User" do
        expect {
          post :create, params: { user: valid_attributes }
        }.to change(User, :count).by(1)
      end

      it "renders a JSON response with the new user" do
        post :create, params: { user: valid_attributes }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new user" do
        post :create, params: { user: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        { last_name: "NewLastName" }
      }

      it "updates the requested user" do
        user = FactoryBot.create(:user)
        put :update, params: { id: user.to_param, user: new_attributes }
        user.reload
        expect(user.last_name).to eq("NewLastName")
      end

      it "renders a JSON response with the user" do
        user = FactoryBot.create(:user)

        put :update, params: { id: user.to_param, user: new_attributes }
        expect(response).to be_successful
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the user" do
        user = FactoryBot.create(:user)

        put :update, params: { id: user.to_param, user: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested user" do
      user = FactoryBot.create(:user)
      expect {
        delete :destroy, params: { id: user.to_param }
      }.to change(User, :count).by(-1)
    end
  end

  private

  def json
    JSON.parse(response.body)
  end
end
