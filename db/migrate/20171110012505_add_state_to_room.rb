class AddStateToRoom < ActiveRecord::Migration[5.1]
  def change
    add_column :rooms, :state, :string
  end
end
