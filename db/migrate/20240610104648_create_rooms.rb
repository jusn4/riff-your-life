class CreateRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :rooms do |t|
      t.references :user, foreign_key: true, null: false

      t.timestamps
    end
  end
end
