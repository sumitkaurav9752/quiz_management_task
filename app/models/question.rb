class Question < ApplicationRecord
  belongs_to :quiz
  has_many :options, dependent: :destroy

  QUESTION_TYPES = ["mcq", "true_false" , "text"]

  accepts_nested_attributes_for :options, allow_destroy: true

  def self.ransackable_attributes(auth_object = nil)
    ["content", "correct_answer", "created_at", "id", "question_type", "quiz_id", "updated_at"]
  end
end
