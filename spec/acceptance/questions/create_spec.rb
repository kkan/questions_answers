require 'rails_helper'

feature 'Create question', %q{
  In order to get help from community
  As an user
  I want to be able ask question
} do

  before { visit new_question_path }

  scenario do
    attrs = attributes_for(:question)
    fill_in 'question[title]', with: attrs[:title]
    fill_in 'question[body]', with: attrs[:body]
    click_on 'Create'

    expect(page).to have_content attrs[:body]
  end
end
