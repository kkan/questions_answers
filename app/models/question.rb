class Question < ApplicationRecord
  belongs_to :user
  has_many :answers, -> { best_first }, dependent: :destroy
  has_one :best_answer, ->{ best }, class_name: 'Answer'

  validates :title, presence: true, length: { minimum: 10, maximum: 100 }
end
