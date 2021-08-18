require 'rails_helper'

RSpec.describe 'Deletes a user', type: :feature do
  it "should be success when user is admin" do
    user_admin = create(:admin)
    user1      = create(:user)
    visit root_path
    click_link 'Login'
    fill_in 'user_email', with: user_admin.email
    fill_in 'user_password', with: user_admin.password
    click_button 'Log in'
    visit users_path
    visit user_path(id: user1.id)
    expect(current_path).to eq user_path(id: user1.id)
    expect(page).to have_content('Welcome!')
    expect(page).to have_content("#{user1.email}")
    user_count = User.count
    click_link 'Delete'
    expect(User.count).to eq(user_count - 1)

    #ActiveRecord methods to check if exact record is deleted from db
    expect { user1.reload }.to raise_error(ActiveRecord::RecordNotFound)
  end

  it "should be redirected when user is not admin" do
    user_regular = create(:user)
    visit root_path
    click_link 'Login'
    fill_in 'user_email', with: user_regular.email
    fill_in 'user_password', with: user_regular.password
    click_button 'Log in'
    visit user_path(id: user_regular.id)
    expect(current_path).to eq static_pages_welcome_path
    expect(page).to have_content('Unauthorized access')
  end
end
