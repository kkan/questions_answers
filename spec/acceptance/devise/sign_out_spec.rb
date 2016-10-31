require 'acceptance_helper'

feature 'Sign out', %q{
  In order to end session
  As authentificated User
  I want to log out
} do  

  given(:user) { create(:user) }

  scenario 'User signs out' do
    sign_in(user)

    visit root_path
    click_on 'Sign out'

    expect(page).to have_content 'Signed out successfully.'
  end

end
