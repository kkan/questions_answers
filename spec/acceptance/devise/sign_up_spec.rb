require 'acceptance_helper'

feature 'Sign up', %q{
  In order to create account
  As a new user
  I want to sign up
} do

  before { visit new_user_registration_path }

  scenario 'User fills fields with good data and signs up' do
    fill_in 'user[email]', with: 'email@test.com' 
    fill_in 'user[password]', with: 'strong_password' 
    fill_in 'user[password_confirmation]', with: 'strong_password'
    click_button 'Sign up'

    expect(page).to have_content('You have signed up successfully.')
  end

  scenario 'User fills some fields with bad data' do
    fill_in 'user[email]', with: 'email@test.com'
    fill_in 'user[password]', with: '1'
    fill_in 'user[password_confirmation]', with: '1'
    click_button 'Sign up'

    expect(page).to have_content('prohibited this user from being saved')
  end

end
