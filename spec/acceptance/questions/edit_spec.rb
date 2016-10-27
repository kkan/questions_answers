require 'acceptance_helper'

feature 'Edit question', %q{
  In order to fix a typo or misspelling
  As an author of question
  I want to be able to edit questions
} do

  given!(:user) { create(:user) }
  given(:question) { create(:question, user: user) }
  given(:question_attrs) { attributes_for(:question) }

  describe 'Author', js: true do
    before do
      sign_in user
      visit question_path(question)
      within '.question' do
        click_on 'Edit'
      end
    end

    scenario 'edit his question' do
      within '.question' do
        fill_in 'question[title]', with: question_attrs[:title]
        fill_in 'question[body]', with: question_attrs[:body]
        click_on 'Update Question'
        expect(page).to_not have_content question.title
        expect(page).to_not have_content question.body
        expect(page).to have_content question_attrs[:title]
        expect(page).to have_content question_attrs[:body]
      end
    end

    scenario 'tries to edit question with invalid attributes' do
      within '.question' do
        fill_in 'question[title]', with: ''
        fill_in 'question[body]', with: ''
        click_on 'Update Question'
      end
      expect(page).to have_content 'Error while updating question'
    end

  end

  scenario 'Unauthentificated user does not see link to editing question', js: true do
    visit question_path(question)
    within '.question' do
      expect(page).to_not have_link 'Edit'
    end
  end

  scenario 'Authentificated user does not see link to editing not his question' do
    sign_in create(:user)
    visit question_path(question)
    within '.question' do
      expect(page).to_not have_link 'Edit'
    end
  end

end
