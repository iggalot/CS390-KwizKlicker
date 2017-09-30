class Room < ApplicationRecord
	has_many :questions
	validates :name, presence: true,
					 length: { minimum: 10 }
end
