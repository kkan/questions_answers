require 'rails_helper'

feature 'Destroy answer', %q{
  In order to don't show my answer to anyone more
  As an user
  I want to be able delete answer
} do
  
  given(:user) { create(:user) }
  given(:attrs) { attributes_for(:answer) }

  scenario do
    sign_in(user)

    create_answer(attrs)
    find('span', text: attrs[:body]).parent.find_link('Delete').click

    expect(page).to have_content 'Answer successfully destroyed'
  end

end
