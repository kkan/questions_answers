require 'acceptance_helper'

feature 'Sign in', %q{
  In order to fully use site
  As an non-authentificated User
  I want to sign in
} do

  given(:user) { create(:user) }

  scenario 'User signs in with correct credentials' do
    sign_in(user)

    expect(page).to have_content 'Signed in successfully.'
  end

  scenario 'User tries to sign in with incorrect credentials' do
    visit new_user_session_path
    fill_in 'user[email]', with: 'wrongemail@test.com'
    fill_in 'user[password]', with: '12345678'
    click_button 'Log in'

    expect(page).to have_content 'Invalid Email or password.'
  end

end

