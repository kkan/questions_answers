class AnswersController < ApplicationController
  before_action :authenticate_user!, only: [ :create, :destroy ]

  def create
    @question = Question.find(params[:question_id])
    @answer = current_user.answers.new(answer_params.merge(question: @question))
    flash[:alert] = @answer.save ? nil : 'Error while saving answer.'
  end

  def destroy
    @answer = current_user.answers.find(params[:id]).destroy
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end
end
