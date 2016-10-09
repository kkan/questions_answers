class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :create, :destroy ]
  before_action :set_question, only: [:show]

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
    @question = Question.new(question_params.merge(user: current_user))

    if @question.save
      redirect_to @question
    else
      flash[:alert] = 'Error while saving question.'
      render :new
    end
  end

  def destroy
    current_user.questions.find(params[:id]).destroy!
    redirect_to questions_path, notice: 'Question successfully destroyed'
  end

  private

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body)
  end
end
