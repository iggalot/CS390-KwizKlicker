class Question < ApplicationRecord
   belongs_to :room
	 has_many :answers, dependent: :destroy
     has_many :responses, dependent: :destroy
end
