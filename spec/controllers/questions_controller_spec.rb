require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:question) { create(:question) }

  describe 'GET #show' do
    before { get :show, params: { id: question } }

    it 'sets proper question to @question var' do
      expect(assigns(:question)).to eq question
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end

    it 'sets new answer' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end
  end

  describe 'GET #new' do
    before { get :new }

    it 'set new question' do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'GET #index' do
    let(:questions) { create_list(:question, 2) }

    before { get :index }

    it 'set list of all question to @questions' do
      expect(assigns(:questions)).to eq questions
    end

    it 'render index page' do
      expect(response).to render_template :index
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'save new question to db' do
        expect { post :create, params: { question: attributes_for(:question) } }.
          to change(Question, :count).by(1)
      end

      it 'redirects to show view with created question' do
        post :create, params: { question: attributes_for(:question) }
        expect(response).to redirect_to question_path(assigns(:question))
      end
    end

    context 'with invalid params' do
      it 'not create new entry in db' do
        expect { post :create, params: { question: attributes_for(:invalid_question) } }.
          to_not change(Question, :count)
      end

      it 're-renders new view' do
        post :create, params: { question: attributes_for(:invalid_question) }
        expect(response).to render_template :new
      end
    end
  end
end
