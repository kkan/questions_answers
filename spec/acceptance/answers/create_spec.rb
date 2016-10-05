require 'rails_helper'

feature 'Answer the question', %q{
  In order to help
  As an user
  I want to be able answer the question
} do

  given(:user) { create(:user) }

  scenario do
    sign_in(user)
    visit question_path(create(:question))
    attrs = attributes_for(:answer)
    fill_in 'answer[body]', with: attrs[:body]
    click_on 'Create'

    expect(page).to have_content attrs[:body]
  end
end
