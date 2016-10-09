class AnswersController < ApplicationController
  before_action :authenticate_user!, only: [ :create, :destroy ]
  
  def create
    @question = Question.find(params[:question_id])
    answer = @question.answers.new(answer_params.merge(question: @question, user: current_user))
    if answer.save
      redirect_to @question
    else
      flash[:notice] = 'Error while saving answer.'
      render 'questions/show'
    end
  end

  def destroy
    @answer = current_user.answers.find(params[:id]).destroy!
    redirect_to question_path(@answer.question_id), notice: 'Answer successfully destroyed'
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end
end
