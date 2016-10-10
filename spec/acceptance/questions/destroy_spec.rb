require 'rails_helper'

feature 'Destroy question', %q{
  In order to don't show my question to anyone more
  As an user
  I want to be able to destroy my question
} do

  given(:user) { create(:user) }

  scenario 'User deletes his question' do
    sign_in(user)
    create_question

    click_on 'Delete'

    expect(page).to have_content 'Question successfully destroyed'
  end

  scenario "Not authentificated user doesn't see link for deleting" do
    question = create(:question, user: user)
    visit question_path(question)

    expect(page).to have_no_link 'Delete'
  end

  scenario "User doesn't see link for deleting not his question" do
    sign_in(user)

    question = create(:question)
    visit question_path(question)

    expect(page).to have_no_link 'Delete'
  end
end
