module AcceptanceMacros
  def sign_in(user)
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'Log in'
  end

  def create_question
    visit new_question_path
    attrs = attributes_for(:question)
    fill_in 'question[title]', with: attrs[:title]
    fill_in 'question[body]', with: attrs[:body]
    click_on 'Create'
  end
end
