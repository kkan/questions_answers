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

  describe 'DELETE #destroy' do
    login_user

    it 'removes answer from database' do
      answer = create(:answer, question: question, user: controller.current_user)

      expect { delete :destroy, params: { question_id: question, id: answer } }.to change(Answer, :count).by(-1)
    end

    it 'redirects to question show page' do
      answer = create(:answer, question: question, user: controller.current_user)
      delete :destroy, params: { question_id: question, id: answer }

      expect(response).to redirect_to question_path(question)
    end
  end
end
