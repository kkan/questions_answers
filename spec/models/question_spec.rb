require 'rails_helper'

RSpec.describe Question, type: :model do
  it { should validate_presence_of(:title) }
  it { should validate_length_of(:title).is_at_least(10).is_at_most(100) }
  it { should have_many(:answers).dependent(:destroy) }

  it 'should return best answer for this question' do
    question = create(:question)
    create_list(:answer, 3, question: question)
    best_answer = create(:answer, question: question, best: true)
    expect(question.best_answer).to eq best_answer
  end
end
