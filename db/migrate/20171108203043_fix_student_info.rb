class FixStudentInfo < ActiveRecord::Migration[5.1]
  def change
    change_table(:student_infos) do |t|
      t.references :rooms, foreign_key: true
      end
    rename_column :student_infos, :room, :roomcode
    end
end
