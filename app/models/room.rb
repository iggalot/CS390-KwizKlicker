class Room < ApplicationRecord
	has_many :questions, dependent: :destroy
	validates :name, presence: true
	validates :password, presence: true,
					 length: { minimum: 2 }
end
