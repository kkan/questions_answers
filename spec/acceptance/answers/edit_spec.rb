require 'acceptance_helper'

feature 'Edit answer', %q{
  In order to fix a typo or misspelling
  As an author of answer
  I want to be able to edit answers
} do

  given!(:user) { create(:user) }
  given!(:question) { create(:question) }
  given!(:answer) { create(:answer, question: question, user: user) }
  given(:answer_attrs) { attributes_for(:answer) }

  describe 'Author', js: true do
    before do
      sign_in user
      visit question_path(question)
      within ".answers" do
        click_on 'Edit'
      end
    end

    scenario 'edit his answer' do
      within '.answers' do
        fill_in 'answer[body]', with: answer_attrs[:body]
        click_on 'Update Answer'
        expect(page).to have_content answer_attrs[:body]
        expect(page).to_not have_content answer.body
      end
    end

    scenario 'tries to edit question with invalid attributes' do
      within '.answers' do
        fill_in 'answer[body]', with: ''
        click_on 'Update Answer'
      end
      expect(page).to have_content 'Error while updating answer'
    end

  end

  scenario 'Unauthentificated user does not see link to editing answer', js: true do
    visit question_path(question)
    within '.answers' do
      expect(page).to_not have_link 'Edit'
    end
  end

  scenario 'Authentificated user does not see link to editing not his answer', js: true do
    sign_in create(:user)
    visit question_path(question)
    within '.answers' do
      expect(page).to_not have_link 'Edit'
    end
  end

end
