require 'rails_helper'

RSpec.describe 'Shows a user', type: :feature do
  let(:user) {User.create!(email: "jane@doe.com",
                role_names: nil,
                admin:true,
                broker:true,
                buyer:true,
                password: "some_password")}

  let(:user1) {User.create!(email: "jane1@doe.com",
                role_names: nil,
                admin:false,
                broker:true,
                buyer:true,
                password: "some_password")}

  it "should be success when current user is admin" do
    visit root_path
    click_link 'Login'
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Log in'
    visit user_path(id: user.id)
    if user.admin?
      expect(current_path).to eq user_path(id: user.id)
      expect(page).to have_content('Welcome!')
      expect(page).to have_content("#{user.email}")
    end
  end

  it "should be redirected when current user is not admin" do
    visit root_path
    click_link 'Login'
    fill_in 'user_email', with: user1.email
    fill_in 'user_password', with: user1.password
    click_button 'Log in'
    visit user_path(id: user1.id)
    if !user1.admin?
      expect(current_path).to eq static_pages_welcome_path
      expect(page).to have_content('Unauthorized access')
    end
  end
end
