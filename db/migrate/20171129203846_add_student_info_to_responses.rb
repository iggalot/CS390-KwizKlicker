class AddStudentInfoToResponses < ActiveRecord::Migration[5.1]
  def change
    add_reference :responses, :student_info, foreign_key: true
  end
end
