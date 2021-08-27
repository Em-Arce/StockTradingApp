require 'rails_helper'

RSpec.describe 'Edits a user', type: :feature do
  it "should be success when user is admin and when inputs are valid" do
    user_admin = create(:admin)
    user1      = create(:user)
    visit root_path
    click_link 'Login'
    fill_in 'user_email', with: user_admin.email
    fill_in 'user_password', with: user_admin.password
    click_button 'Log in'
    visit edit_user_path(id: user1.id)
    expect(current_path).to eq edit_user_path(id: user1.id)
    expect(page).to have_content('Edit User')
    fill_in 'Email', with: 'testedit@test.com'
    page.find('#user_broker option[value="true"]').select_option
    page.find('#user_buyer option[value="true"]').select_option
    page.find('#user_status option[value="Approved"]').select_option
    click_button 'Submit'
    visit user_path(id: user1.id)
    expect(current_path).to eq user_path(id: user1.id)
    expect(page).to have_content ("Welcome!")
    expect(page).to have_content ("testedit@test.com")
    expect(page).to have_content ("Approved")

    user1 = User.order("id").last
    expect(user1.email).to eq('testedit@test.com')
    expect(user1.broker).to eq(true)
    expect(user1.buyer).to eq(true)
    expect(user1.status).to eq("Approved")
  end

  it "should be redirected when user is not admin" do
    user_regular = create(:user)
    visit root_path
    click_link 'Login'
    fill_in 'user_email', with: user_regular.email
    fill_in 'user_password', with: user_regular.password
    click_button 'Log in'
    visit edit_user_path(id: user_regular.id)
    expect(current_path).to eq static_pages_welcome_path
    expect(page).to have_content('Unauthorized access')
  end

  context 'should not be success when user is admin and' do
    it "when email is blank" do
      user_admin = create(:admin)
      user1      = create(:user)
      visit root_path
      click_link 'Login'
      fill_in 'user_email', with: user_admin.email
      fill_in 'user_password', with: user_admin.password
      click_button 'Log in'
      visit edit_user_path(id: user1.id)
      expect(current_path).to eq edit_user_path(id: user1.id)
      expect(page).to have_content('Edit User')
      fill_in 'Email', with: ''
      page.find('#user_broker option[value="true"]').select_option
      page.find('#user_buyer option[value="true"]').select_option
      click_button 'Submit'
      expect(current_path).to eq user_path(id: user1.id)
      expect(page).to have_content('Edit User')
      expect(page).to have_content ("Email can't be blank")
    end

    it "when buyer and broker are both false" do
      user_admin = create(:admin)
      user1      = create(:user)
      visit root_path
      click_link 'Login'
      fill_in 'user_email', with: user_admin.email
      fill_in 'user_password', with: user_admin.password
      click_button 'Log in'
      visit edit_user_path(id: user1.id)
      expect(current_path).to eq edit_user_path(id: user1.id)
      expect(page).to have_content('Edit User')
      fill_in 'Email', with: "#{user1.email}"
      page.find('#user_broker option[value="false"]').select_option
      page.find('#user_buyer option[value="false"]').select_option
      click_button 'Submit'
      expect(current_path).to eq user_path(id: user1.id)
      expect(page).to have_content('Edit User')
      expect(page).to have_content ("Broker and buyer fields cannot both be false.")
    end
  end
end
