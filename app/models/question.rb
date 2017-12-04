class Question < ApplicationRecord
   belongs_to :room
	 has_many :answers, dependent: :destroy
	 validates :body, presence: true
end
