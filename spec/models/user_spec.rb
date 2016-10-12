require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:questions) }
  it { should have_many(:answers) }

  it 'return true if user author of question' do
    user = create(:user)
    question = create(:question, user: user)
    expect(user.author_of?(question)).to be_truthy
  end

  it 'return false if user not author of question' do
    user = create(:user)
    question = create(:question, user: create(:user))
    expect(user.author_of?(question)).to be_falsey
  end
end
