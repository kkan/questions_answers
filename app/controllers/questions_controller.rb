class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :create, :destroy ]
  before_action :set_question, only: [:show, :destroy]

  def show
    @answer = Answer.new
  end

  def new
    @question = Question.new
  end

  def index
    @questions = Question.all
  end

  def create
    @question = Question.create(question_params.merge(user: current_user))

    if @question.save
      redirect_to @question
    else
      flash[:alert] = 'Error while saving question.'
      render :new
    end
  end

  def destroy
    if @question.user == current_user
      @question.destroy
      redirect_to questions_path, notice: 'Question successfully destroyed'
    else
      flash[:alert] = 'You are trying to delete not yours question'
      redirect_back(fallback_location: questions_path) 
    end
  end

  private

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body)
  end
end
