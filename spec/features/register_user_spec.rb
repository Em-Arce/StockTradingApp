require 'rails_helper'

#User is both broker and buyer
RSpec.describe "Register a new user", type: :feature do
  it 'when valid inputs are given' do
    visit root_path
    click_link 'Sign Up'
    fill_in 'Email', with: 'testreg@test.com'
    page.find('#user_broker option[value="true"]').select_option
    page.find('#user_buyer option[value="true"]').select_option
    fill_in 'user_password', with: 'password'
    fill_in 'user_password_confirmation', with: 'password'
    click_button 'Sign up'
    #expect(page).to have_content('Welcome!')
    #expect(current_path).to eq welcome_path
    user = User.order('id').last
    user_count = User.count
    expect(user_count).to eq(1)
    expect(user.email).to eq('testreg@test.com')
    expect(user.broker).to eq(true)
    expect(user.buyer).to eq(true)
  end

  it 'not when broker and buyer fields are both set to false' do
    visit root_path
    click_link 'Sign Up'
    fill_in 'Email', with: 'test@test.com'
    page.find('#user_broker option[value="false"]').select_option
    page.find('#user_buyer option[value="false"]').select_option
    fill_in 'user_password', with: 'password'
    fill_in 'user_password_confirmation', with: 'password'
    click_button 'Sign up'
    expect(page).to have_content("Broker and buyer fields cannot both be false.")
    expect(current_path).to eq '/users'
    user = User.count
    expect(user).to eq(0)
  end

  it 'not when password and password confirmation fields are different' do
    visit root_path
    click_link 'Sign Up'
    fill_in 'Email', with: 'test@test.com'
    fill_in 'user_password', with: 'testtest'
    fill_in 'user_password_confirmation', with: 'abcd1234'
    click_button 'Sign up'
    expect(page).to have_content("Password confirmation doesn't match Password")
    #'/users' replace below with this
    expect(current_path).to eq '/users'
    user = User.count
    expect(user).to eq(0)
  end

  it 'not when invalid email is given' do
    visit root_path
    click_link 'Sign Up'
    fill_in 'Email', with: 'test.test.com'
    fill_in 'user_password', with: 'testtest'
    fill_in 'user_password_confirmation', with: 'testtest'
    click_button 'Sign up'
    expect(page).to have_content("Email is invalid")
    expect(current_path).to eq '/users'
    user = User.count
    expect(user).to eq(0)
  end

  it 'not when email field is blank' do
    visit root_path
    click_link 'Sign Up'
    fill_in 'Email', with: ''
    fill_in 'user_password', with: 'testtest'
    fill_in 'user_password_confirmation', with: 'testtest'
    click_button 'Sign up'
    expect(page).to have_content("Email can't be blank")
    expect(current_path).to eq '/users'
    user = User.count
    expect(user).to eq(0)
  end

  it 'not when password field is blank' do
    visit root_path
    click_link 'Sign Up'
    fill_in 'Email', with: 'test@test.com'
    fill_in 'user_password', with: ''
    fill_in 'user_password_confirmation', with: 'testtest'
    click_button 'Sign up'
    expect(page).to have_content("Password can't be blank")
    expect(current_path).to eq '/users'
    user = User.count
    expect(user).to eq(0)
  end

  it 'not when password confirmation field is blank' do
    visit root_path
    click_link 'Sign Up'
    fill_in 'Email', with: 'test@test.com'
    fill_in 'user_password', with: 'testtest'
    fill_in 'user_password_confirmation', with: ''
    click_button 'Sign up'
    expect(page).to have_content("Password confirmation doesn't match Password")
    expect(current_path).to eq '/users'
    user = User.count
    expect(user).to eq(0)
  end

  it 'not when email is already used for registration' do
    visit root_path
    click_link 'Sign Up'
    fill_in 'Email', with: 'test@test.com'
    fill_in 'user_password', with: 'testtest'
    fill_in 'user_password_confirmation', with: 'testtest'
    click_button 'Sign up'
    #expect(page).to have_content("Welcome!")
    #expect(current_path).to eq welcome_path
    click_link 'Logout'
    click_link 'Sign Up'
    fill_in 'Email', with: 'test@test.com'
    fill_in 'user_password', with: 'testtest'
    fill_in 'user_password_confirmation', with: 'testtest'
    click_button 'Sign up'
    expect(page).to have_content("Email has already been taken")
    expect(current_path).to eq '/users'
    user = User.count
    expect(user).to eq(1)
  end
end



RSpec.describe "Registration form", type: :feature do
  it 'should redirect to login page' do
    visit root_path
    click_link 'Sign Up'
    click_link 'Log in'
    expect(page).to have_content('Log in')
    expect(current_path).to eq '/users/sign_in'
  end
end
