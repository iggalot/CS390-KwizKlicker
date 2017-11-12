class AddAnsweridxToResponse < ActiveRecord::Migration[5.1]
  def change
    add_column :responses, :answeridx, :integer
  end
end
