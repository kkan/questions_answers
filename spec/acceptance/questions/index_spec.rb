require 'rails_helper'

feature 'User view list of questions', %q{
  In order to find interesting question
  As an user
  I want to view list of question
} do

  scenario 'User see all questions' do
    question_titles = create_list(:question, 5).map(&:title)

    visit questions_path
    question_titles.each { |qt| expect(page).to have_content qt }
  end

end
