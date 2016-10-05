require 'rails_helper'

feature 'Destroy question', %q{
  In order to don't show my question to anyone more
  As an user
  I want to be able to destroy my question
} do

  given(:user) { create(:user) }

  scenario do
    sign_in(user)
    create_question

    click_on 'Delete'

    expect(page).to have_content 'Question successfully destroyed'
  end
end
