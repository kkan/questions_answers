require 'rails_helper'

feature 'Answer the question', %q{
  In order to help
  As an user
  I want to be able answer the question
} do

  given(:user) { create(:user) }
  given(:attrs) { attributes_for(:answer) }

  scenario 'User creates answer' do
    sign_in(user)
    create_answer(attrs)

    expect(page).to have_content attrs[:body]
  end

  scenario "User can't create answer with empty body and see error" do
    sign_in(user)
    create_answer(body: '')

    expect(page).to have_content 'Error while saving answer.'
  end

  scenario "Not authentificated user doesn't see form for answer" do
    visit question_path(create(:question))

    expect(page).to have_no_field 'answer[body]'
  end
end
