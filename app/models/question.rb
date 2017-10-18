class Question < ApplicationRecord
   belongs_to :room
	 has_many :answers
end
