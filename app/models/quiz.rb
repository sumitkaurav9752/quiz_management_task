class Quiz < ApplicationRecord
    has_many :questions, dependent: :destroy
    accepts_nested_attributes_for :questions, allow_destroy: true

    validates :title, presence: true
    def self.ransackable_associations(auth_object = nil)
        ["questions"]
    end
    def self.ransackable_attributes(auth_object = nil)
        ["created_at", "description", "id", "title", "updated_at"]
    end
end
