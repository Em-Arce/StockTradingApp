require 'rails_helper'

RSpec.describe 'Shows a user', type: :feature do
  it "should be success when user is admin" do
    user_admin = create(:admin)
    user1      = create(:user)
    visit root_path
    click_link 'Login'
    fill_in 'user_email', with: user_admin.email
    fill_in 'user_password', with: user_admin.password
    click_button 'Log in'
    visit users_path
    expect(current_path).to eq users_path
    expect(page).to have_content('Awaiting account approval')
    expect(page).to have_content('All users')
    expect(page).to have_content("#{user1.email}")
    first("a[href='/users/#{user1.id}']").click
    visit user_path(id: user1.id)
    expect(current_path).to eq user_path(id: user1.id)
    expect(page).to have_content('Welcome!')
    expect(page).to have_content("#{user1.email}")
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

  context 'checks for buttons' do
    it 'Back: should redirect admin to index page' do
      user_admin = create(:admin)
      user1      = create(:user)
      visit root_path
      click_link 'Login'
      fill_in 'user_email', with: user_admin.email
      fill_in 'user_password', with: user_admin.password
      click_button 'Log in'
      visit user_path(id: user1.id)
      expect(current_path).to eq user_path(id: user1.id)
      click_link 'Back'
      visit users_path
      expect(current_path).to eq users_path
      expect(page).to have_content('Awaiting account approval')
      expect(page).to have_content('All users')
    end
  end

  context 'checks for buttons' do
    it 'Edit: should redirect admin to edit page' do
      user_admin = create(:admin)
      user1      = create(:user)
      visit root_path
      click_link 'Login'
      fill_in 'user_email', with: user_admin.email
      fill_in 'user_password', with: user_admin.password
      click_button 'Log in'
      visit user_path(id: user1.id)
      expect(current_path).to eq user_path(id: user1.id)
      click_link 'Edit'
      visit edit_user_path(id: user1.id)
      expect(current_path).to eq edit_user_path(id: user1.id)
      expect(page).to have_content('Edit User')
    end
  end
end
