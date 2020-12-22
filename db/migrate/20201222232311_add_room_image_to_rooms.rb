class AddRoomImageToRooms < ActiveRecord::Migration[6.0]
  def change
    add_column :rooms, :room_image, :string
  end
end
