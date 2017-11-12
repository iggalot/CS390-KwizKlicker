class CreateResponses < ActiveRecord::Migration[5.1]
  def change
    create_table :responses do |t|
      t.string :username
      t.references :question, foreign_key: true

      t.timestamps
    end
  end
end
