class AddActiveQuestionToRoom < ActiveRecord::Migration[5.1]
  def change
    add_column :rooms, :active_question, :integer
  end
end
