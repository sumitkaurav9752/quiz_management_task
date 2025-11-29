class QuizSubmission < ApplicationRecord
  belongs_to :user
  belongs_to :quiz
  has_many :submission_answers, dependent: :destroy

  accepts_nested_attributes_for :submission_answers
    def self.ransackable_associations(auth_object = nil)
    ["quiz", "submission_answers", "user"]
  end


  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "quiz_id", "score", "updated_at", "user_id"]
  end
end
