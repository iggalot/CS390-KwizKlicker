class StudentInfo < ApplicationRecord
  validates :name, presence: true
  validates :room, presence: true,
            length: 4
end
