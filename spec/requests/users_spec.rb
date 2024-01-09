require 'rails_helper'

RSpec.describe UsersController, type: :request do
  before do
    @user = FactoryBot.create(:user, first_name: 'John', last_name: 'Doe', email: 'john.doe@example.com', birth_date: '2000-01-01', admission_date: '2022-01-01', is_active: true, sex: 'M', last_sign_in_at: Time.current)
  end

  it "should get index" do
    get users_url, as: :json
    expect(response).to have_http_status(:success)
  end

  it "should create user" do
    expect do
      post users_url, params: { user: { first_name: 'Jane', last_name: 'Doe', email: 'jane.doe@example.com', birth_date: '2001-02-02', admission_date: '2023-02-02', is_active: true, sex: 'F', last_sign_in_at: Time.current } }, as: :json
    end.to change(User, :count).by(1)

    expect(response).to have_http_status(:created)
  end

  it "should show user" do
    get user_url(@user), as: :json
    expect(response).to have_http_status(:success)
  end

  it "should update user" do
    patch user_url(@user), params: { user: { first_name: 'John', last_name: 'Smith' } }, as: :json
    expect(response).to have_http_status(:success)
  end

  it "should destroy user" do
    expect do
      delete user_url(@user), as: :json
    end.to change(User, :count).by(-1)

    expect(response).to have_http_status(:no_content)
  end
end
