class CreateStudentInfos < ActiveRecord::Migration[5.1]
  def change
    create_table :student_infos do |t|
      t.string :name
      t.string :room

      t.timestamps
    end
  end
end
