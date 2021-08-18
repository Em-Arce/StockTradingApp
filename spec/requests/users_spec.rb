require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user_admin) {User.create!(email: 'test@admin.com',
                      role_names: nil,
                      admin:true,
                      broker:true,
                      buyer:true,
                      password: 'some_password' )
                    }

  before do
    sign_in user_admin
  end
  #happy paths
  describe "GET #index" do
    it "should have status 200" do
      get users_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #show" do
    it "should have status 200" do
      get user_path(user_admin.id)
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #edit" do
    it "should have status 200" do
      get edit_user_path(user_admin.id)
      expect(response).to have_http_status(200)
    end
  end
end

