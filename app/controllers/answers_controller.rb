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

  def update
    @answer = current_user.answers.find(params[:id])
    flash[:alert] = @answer.update(answer_params) ? nil : 'Error while updating answer'
  end

  def set_best
    @answer = current_user.questions.find(params[:question_id]).answers.find(params[:id])
    flash[:alert] = @answer.update(best: true) ? nil : 'Error while setting best answer'
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end
end
