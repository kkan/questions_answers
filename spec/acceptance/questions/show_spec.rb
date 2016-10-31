require 'acceptance_helper'

feature 'Question body and answers to it page', %q{
  In order to find answer to question
  As an user
  I want to view question and answers to it
} do

  scenario 'User see question and answers to it' do
    question = create(:question)
    answers = create_list(:answer, 4, question: question).map(&:body)

    visit question_path(question)
    expect(page).to have_content question.body
    answers.each { |a| expect(page).to have_content a }
  end

end
