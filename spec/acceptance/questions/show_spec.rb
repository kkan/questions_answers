require 'rails_helper'

feature 'Question body and answers to it page', %q{
  In order to find answer to question
  As an user
  I want to view question and answers to it
} do

  scenario do
    question = create(:question)
    answers = create_list(:answer, 4, question: question).map(&:body)

    visit question_path(question)
    expect(page).to have_content question.body
    2.times { expect(page).to have_content answers.sample }
  end

end
