class Question < ApplicationRecord
   belongs_to :room, dependent: :destroy
	 has_many :answers, dependent: :destroy
	validates :body, presence: true
end
