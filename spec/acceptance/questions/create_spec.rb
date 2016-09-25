require 'rails_helper'

feature 'User creates question', %q{
  In order to get help from community
  As an user
  I want to be able ask question
} do

  before { visit new_question_path }

  scenario 'with valid fields' do
    fill_in 'question[title]', with: attributes_for(:question)[:title]
    fill_in 'question[body]', with: attributes_for(:question)[:body]
    click_on 'Create'

    expect(page).to have_content attributes_for(:question)[:body]
  end

  scenario 'with invalid fields' do
    fill_in 'question[title]', with: attributes_for(:invalid_question)[:title]
    click_on 'Create'

    expect(page).to have_content 'Error while saving question.'
  end
end
