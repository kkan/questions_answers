class AnswersController < ApplicationController
  before_action :authenticate_user!, only: [ :create, :destroy ]
  
  def create
    @question = Question.find(params[:question_id])
    @answer = Answer.new(answer_params.merge(question: @question, user: current_user))
    if @answer.save
      redirect_to @question
    else
      flash[:notice] = 'Error while saving answer.'
      render 'questions/show'
    end
  end

  def destroy
    @answer = Answer.find(params[:id])
    if @answer.user == current_user
      @answer.destroy
      flash[:notice] = 'Answer successfully destroyed'
    else
      flash[:alert] = 'You can\'t delete not yours answer'
    end
    redirect_back(fallback_location: question_path(@answer.question))
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end
end
