
require 'rails_helper'

RSpec.describe 'Login', type: :feature do
  let(:user) {User.create!(email: 'test@example.com', password: 'password')}

  before do
    visit root_path
    click_link 'Login'
  end

  it 'when registered user gives valid inputs' do
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Log in'
    #expect(current_path).to eq categories_path
    #expect(page).to have_content('Categories')
  end

    it 'when email field is blank' do
        fill_in 'user_email', with: ''
        fill_in 'user_password', with: user.password
        click_button 'Log in'
        expect(current_path).to eq '/users/sign_in'
        expect(page).to have_content("Invalid Email or password.")
    end

    it 'when password field is blank' do
        fill_in 'user_email', with: user.email
        fill_in 'user_password', with: ''
        click_button 'Log in'
        expect(current_path).to eq '/users/sign_in'
        expect(page).to have_content("Invalid Email or password.")
    end

    it 'when both email and password fields are blank' do
        fill_in 'user_email', with: ''
        fill_in 'user_password', with: ''
        click_button 'Log in'
        expect(current_path).to eq '/users/sign_in'
        expect(page).to have_content("Invalid Email or password.")
    end
end

RSpec.describe "Login form buttons check", type: :feature do
    it 'for sign up' do
        visit root_path
        click_link 'Login'
        click_link 'Sign up'
        expect(page).to have_content('Create an Account')
        expect(current_path).to eq '/users/sign_up'
    end

    it 'for forgot password' do
        visit root_path
        click_link 'Login'
        click_link 'Forgot your password?'
        expect(page).to have_content('Forgot your password?')
        expect(current_path).to eq '/users/password/new'
    end
end
