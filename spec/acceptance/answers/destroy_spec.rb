require 'rails_helper'

feature 'Destroy answer', %q{
  In order to don't show my answer to anyone more
  As an user
  I want to be able delete answer
} do
  
  given(:user) { create(:user) }
  given(:attrs) { attributes_for(:answer) }

  scenario 'User deletes his answer' do
    sign_in(user)

    answer = create(:answer, user: user)
    visit question_path(answer.question_id)
    within('.answers') { click_on 'Delete' }

    expect(page).to have_content 'Answer successfully destroyed'
  end

  scenario "Not authentificated user doesn't see link for deleting" do
    answer = create(:answer, user: user)
    visit question_path(answer.question_id)

    within('table') { expect(page).to have_no_link 'Delete' }
  end

  scenario "User doesn't see link for deleting not his answer" do
    sign_in(user)

    answer = create(:answer)
    visit question_path(answer.question_id)

    within('table') { expect(page).to have_no_link 'Delete' }
  end

end
