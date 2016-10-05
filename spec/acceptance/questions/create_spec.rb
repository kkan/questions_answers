require 'rails_helper'

feature 'Create question', %q{
  In order to get help from community
  As an user
  I want to be able ask question
} do

  given(:user) { create(:user) }
  given(:attrs) { attributes_for(:question) }

  scenario do
    sign_in(user)
    create_question(attrs)

    expect(page).to have_content attrs[:body]
  end
end
