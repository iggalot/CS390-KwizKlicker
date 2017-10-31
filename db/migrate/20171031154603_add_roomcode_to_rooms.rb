class AddRoomcodeToRooms < ActiveRecord::Migration[5.1]
  def change
    add_column :rooms, :roomcode, :string
  end
end
