class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user

  validates :body, presence: true
  validates :best, uniqueness: { scope: :question_id }, if: :best?

  scope :best, ->{ where(best: true) }
  scope :best_first, ->{ order("answers.best = 'true' DESC") }

  def set_best
    transaction do
      Answer.where(question_id: question_id).update_all(best: false)
      update!(best: true)
    end
  end
end
