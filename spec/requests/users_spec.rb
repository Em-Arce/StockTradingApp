require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user) {User.create!(email: 'test@example.com', role_names: nil,
                admin:false, broker:true, buyer:true,
                password: 'password' )}


  describe "GET #index" do
    it "should be a success" do
      get users_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #show" do
    it "should be a success" do
      get user_path(user.id)
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #edit" do
    it "should be a success" do
      get edit_user_path(user.id)
      expect(response).to have_http_status(200)
    end
  end
end
