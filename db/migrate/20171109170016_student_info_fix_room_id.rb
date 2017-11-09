class StudentInfoFixRoomId < ActiveRecord::Migration[5.1]
  def change
    remove_column :student_infos, :rooms_id
    change_table(:student_infos) do |t|
      t.references :room, foreign_key: true
    end
  end
end
