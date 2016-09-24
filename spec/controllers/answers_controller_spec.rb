require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create(:question) }

  describe 'POST #create' do
    describe 'valid params' do
      it 'creates answer in db' do
        expect { post :create, params: { question_id: question, answer: attributes_for(:answer) } }.
          to change(Answer, :count).by(1)
      end

      it 'redirects back to question page' do
        post :create, params: { question_id: question, answer: attributes_for(:answer) }
        expect(response).to redirect_to question
      end
    end
    describe 'invalid params' do
      it 'don\'t creates answer in db' do
        expect { post :create, params: { question_id: question, answer: { body: '' } } }.
          not_to change(Answer, :count)
      end

      it 'redirects back to question page' do
        post :create, params: { question_id: question, answer: { body: '' } }
        expect(response).to redirect_to question
      end
    end
  end
end
