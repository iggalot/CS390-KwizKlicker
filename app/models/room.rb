class Room < ApplicationRecord
	has_many :questions, dependent: :destroy
	has_many :student_infos, dependent: :destroy
	validates :name, presence: true
	validates :password, presence: true,
						length: { minimum: 2 }
	validates :roomcode, presence: true,
						length: {is: 4} , format: { with: /\A[a-zA-Z]+\z/}
end
