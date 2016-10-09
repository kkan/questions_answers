require 'rails_helper'

RSpec.describe User, type: :model do
  it 'check if user author of question' do
    user = create(:user)
    question = create(:question, user: user)
    expect(user.author_of?(question)).to be_truthy
  end
end
