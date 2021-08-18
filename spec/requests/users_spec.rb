require 'rails_helper'

RSpec.describe "Users", type: :request do
  #happy paths
  describe "GET #index" do
    it "should have status 200" do
      user_admin = create(:admin)
      sign_in user_admin
      get users_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #show" do
    it "should have status 200" do
      user_admin = create(:admin)
      sign_in user_admin
      get user_path(user_admin.id)
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #edit" do
    it "should have status 200" do
      user_admin = create(:admin)
      sign_in user_admin
      get edit_user_path(user_admin.id)
      expect(response).to have_http_status(200)
    end
  end
end

