class Question < ApplicationRecord
   belongs_to :rooms
	 has_many :answers
end
