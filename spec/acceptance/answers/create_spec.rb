require 'rails_helper'

feature 'Answer the question', %q{
  In order to help
  As an user
  I want to be able answer the question
} do

  given(:user) { create(:user) }
  given(:attrs) { attributes_for(:answer) }

  scenario do
    sign_in(user)
    create_answer(attrs)

    expect(page).to have_content attrs[:body]
  end
end
