require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create(:question) }

  describe 'POST #create' do
    describe 'valid params' do
      login_user
      
      it 'creates answer in db' do
        q = question
        expect { post :create, params: { question_id: q, answer: attributes_for(:answer) } }.
          to change(q.answers, :count).by(1)
      end

      it 'redirects back to question page' do
        post :create, params: { question_id: question, answer: attributes_for(:answer) }
        expect(response).to redirect_to question
      end
    end
    describe 'invalid params' do
      login_user

      it 'don\'t creates answer in db' do
        expect { post :create, params: { question_id: question, answer: { body: '' } } }.
          not_to change(Answer, :count)
      end

      it 'redirects back to question page' do
        post :create, params: { question_id: question, answer: { body: '' } }
        expect(response).to render_template 'questions/show'
      end
    end
  end
end
