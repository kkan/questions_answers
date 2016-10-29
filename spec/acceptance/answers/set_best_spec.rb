require 'acceptance_helper'

feature 'Set best answer', %q{
  In order to help others to find correct answer for question
  As an author of question
  I want to be able to set best answer for question
} do

  given!(:user){ create(:user) }
  given(:question){ create(:question, user: user) }

  before do
    answers = create_list(:answer, 3, question: question)
    @answer = answers.sample
  end

  scenario 'Author sets best answer for his question' do
    sign_in user
    visit question_path(question)
    within '.answers' do
      answer_node = find("#answer_#{@answer.id}")
      answer_node.click_link('Best')
      expect(answer_node[:class].include?('best')).to be_truthy
      expect(answer_node).to_not have_link 'Best'
    end
  end

  scenario 'Unauthentificated user does not see link for setting best answer' do
    visit question_path(question)
    within '.answers' do
      expect(page).to_not have_link('Best')
    end
  end

  scenario 'User cannot set best answer fo not his question' do
    sign_in user
    visit question_path(create(:question))
    within '.answers' do
      expect(page).to_not have_link('Best')
    end
  end

end
