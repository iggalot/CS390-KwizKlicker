class StudentInfo < ApplicationRecord
  validates :name, presence: true,
            length: { minimum: 1 }
  validates :room, presence: true,
            length: 4
end
