class CreateRooms < ActiveRecord::Migration[6.0]
  def change
    create_table :rooms do |t|
      t.string :name
      t.string :title
      t.text :description
      t.text :sidebar

      t.timestamps
    end
    add_index :rooms, :name, unique: true
  end
end
