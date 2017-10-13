class Room < ApplicationRecord
	has_many :questions
	validates :name, presence: true,
					 length: { minimum: 10 }
	validates :password, presence: true,
					 length: { minimum: 2 }
end
