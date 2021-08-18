require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:current_user) {User.create!(email: 'test@admin.com',
                      role_names: nil,
                      admin:true,
                      broker:true,
                      buyer:true,
                      password: 'some_password' )}

  let(:valid_attributes) do
    {
      'id'         => '1',
      'email'      => 'test@subject.com'
      'role_names' => nil,
      'admin'      => true,
      'broker'     => true,
      'buyer'      => true,
      'password'   => 'some_password1'
      'user'       => current_user
    }
  end

  let(:invalid_attributes) do
    {
      'id'         => '1',
      'email'      => ' '
      'role_names' => nil,
      'admin'      => true,
      'broker'     => true,
      'buyer'      => true,
      'password'   => 'some_password1'
      'user'       => current_user
    }
  end

  describe "GET #index" do
    it "renders a successful response" do
      user = User.new(valid_attributes)
      user.user = current_user
      user.save
      get users_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #show" do
    it "should be redirected when user is not admin" do
      get user_path(user.id)
      expect(response).to have_http_status(302)
    end
  end

  describe "GET #edit" do
    it "should be redirected when user is not admin" do
      get edit_user_path(user.id)
      expect(response).to have_http_status(302)
    end
  end
end
