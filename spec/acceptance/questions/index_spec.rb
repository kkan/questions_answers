require 'rails_helper'

feature 'User view list of questions', %q{
  In order to find interesting question
  As an user
  I want to view list of question
} do

  scenario do
    question_titles = create_list(:question, 5).map(&:title)

    visit questions_path
    2.times { expect(page).to have_content question_titles.sample }
  end

end