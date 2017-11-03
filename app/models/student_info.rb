class StudentInfo < ApplicationRecord
  validates :name, presence: true
  validates :room, presence: true,
            length: {is: 4}, format: { with: /\A[a-zA-Z]+\z/}
end