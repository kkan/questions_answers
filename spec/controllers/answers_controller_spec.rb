require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create(:question) }

  describe 'POST #create' do
    describe 'valid params' do
      login_user

      it 'creates answer in db' do
        q = question
        expect do
          post :create, params: { question_id: q, answer: attributes_for(:answer) }, format: :js
        end.to change(q.answers, :count).by(1)
      end

      it 'connect new answer to current user' do
        expect do
          post :create, params: { question_id: question, answer: attributes_for(:answer) }, format: :js
        end.to change(controller.current_user.answers, :count).by(1)
      end

      it 'redirects back to question page' do
        post :create, params: { question_id: question, answer: attributes_for(:answer) }, format: :js
        expect(response).to render_template 'create'
      end
    end

    describe 'invalid params' do
      login_user

      it 'don\'t creates answer in db' do
        expect { post :create, params: { question_id: question, answer: { body: '' } }, format: :js }.
          not_to change(Answer, :count)
      end

      it 'redirects back to question page' do
        post :create, params: { question_id: question, answer: { body: '' }, format: :js }
        expect(response).to render_template 'create'
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

    it 'does not delete answer form db if it is not user\'s answer' do
      answer = create(:answer, question: question, user: create(:user))
      
      expect { delete :destroy, params: { question_id: question, id: answer } }.to_not change(Answer, :count)
    end
  end
end
