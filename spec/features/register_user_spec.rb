require 'rails_helper'

RSpec.describe "Register a new user", type: :feature do
  it 'when valid inputs are given' do
    visit root_path
    click_link 'Sign Up'
    fill_in 'Email', with: 'test@test.com'
    fill_in 'user_password', with: 'testtest'
    fill_in 'user_password_confirmation', with: 'testtest'
    click_button 'Sign up'
    #expect(page).to have_content('Welcome!')
    #expect(current_path).to eq welcome_path
    user = User.order('id').last
    user_count = User.count
    expect(user.email).to eq('test@test.com')
    expect(user_count).to eq(1)
  end

  it 'when password and password confirmation fields are different' do
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

  it 'when invalid email is given' do
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

  it 'when email field is blank' do
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

  it 'when password field is blank' do
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

  it 'when password confirmation filed is blank' do
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

  it 'when email is already used for registration' do
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
  it 'redirects to login page' do
    visit root_path
    click_link 'Sign Up'
    click_link 'Log in'
    expect(page).to have_content('Log in')
    expect(current_path).to eq '/users/sign_in'
  end
end
