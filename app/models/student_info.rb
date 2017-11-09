class StudentInfo < ApplicationRecord
  validates :name, presence: true
  validates :room, presence: true,
            length: {is: 4}, format: { with: /\A[a-zA-Z]+\z/}
            before_save :upcase_field
  validates_uniqueness_of :name, :scope =>:room


def upcase_field
  self.room.upcase!
end

end