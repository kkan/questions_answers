require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should belong_to(:question) }
  it { should validate_presence_of(:body) }
  it 'validates existing of question' do
    expect(build(:answer, question: nil)).to_not be_valid
  end

  it 'validates existing only one best answer for question' do
    question = create(:question)
    create_list(:answer, 3, question: question)
    create(:answer, question: question, best: true)
    expect(build(:answer, question: question, best: true)).to_not be_valid
  end

  it 'should return all best answers' do
    create_list(:answer, 3)
    best_answers = create_list(:answer, 3, best: true)
    expect(Answer.best).to eq best_answers
  end

  describe 'set answer' do
    before do
      question = create(:question)
      @answer = create_list(:answer, 3, question: question).sample
      create(:answer, question: question, best: true)
    end

    it 'should set best answer' do
      @answer.set_best
      expect(@answer.best).to be_truthy
    end

    it 'should return true' do
      expect(@answer.set_best).to be_truthy
    end
  end
end
