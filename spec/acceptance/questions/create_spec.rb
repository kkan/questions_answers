require 'acceptance_helper'

feature 'Create question', %q{
  In order to get help from community
  As an user
  I want to be able ask question
} do

  given(:user) { create(:user) }
  given(:attrs) { attributes_for(:question) }

  scenario 'User creates new answer' do
    sign_in(user)
    create_question(attrs)

    expect(page).to have_content attrs[:body]
  end

  scenario "User doesn't fill title and see error" do
    sign_in(user)
    create_question(title: '', body: 'Text of question')

    expect(page).to have_content 'Error while saving question.'
  end

  scenario "Not authentificated user doesn't see form for new question" do
    visit new_question_path

    expect(page).to have_no_field 'question[title]'
    expect(page).to have_no_field 'question[body]'
    expect(page).to have_no_button 'Create'
  end
end
