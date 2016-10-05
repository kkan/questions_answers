require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should belong_to(:question) }
  it { should validate_presence_of(:body) }
  it 'validates existing of question' do
    expect(build(:answer, question: nil)).to_not be_valid
  end
end
