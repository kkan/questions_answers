require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create(:question) }
  let(:answer_attrs) { attributes_for(:answer) }

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

      it 'renders create.js' do
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

      it 'renders create.js' do
        post :create, params: { question_id: question, answer: { body: '' }, format: :js }
        expect(response).to render_template 'create'
      end
    end
  end

  describe 'PATCH #update' do
    login_user

    before do
      @answer = create(:answer, user: controller.current_user)
      patch :update, params: { question_id: question, id: @answer, answer: answer_attrs }, format: :js
    end

    it 'assigns @answer' do
      expect(assigns(:answer)).to eq @answer
    end

    it 'changes answer attributes' do
      @answer.reload
      expect(@answer.body).to eq answer_attrs[:body]
    end

    it 'renders update.js' do
      expect(response).to render_template :update
    end
  end

  describe 'DELETE #destroy' do
    login_user

    it 'removes answer from database' do
      answer = create(:answer, question: question, user: controller.current_user)

      expect do
        delete :destroy, params: { question_id: question, id: answer }, format: :js
      end.to change(Answer, :count).by(-1)
    end

    it 'renders destroy.js' do
      answer = create(:answer, question: question, user: controller.current_user)
      delete :destroy, params: { question_id: question, id: answer }, format: :js

      expect(response).to render_template 'destroy'
    end

    it 'does not delete answer form db if it is not user\'s answer' do
      answer = create(:answer, question: question, user: create(:user))

      expect { delete :destroy, params: { question_id: question, id: answer } }.to_not change(Answer, :count)
    end
  end
end
