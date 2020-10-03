class AddPostVideoToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :post_video, :string
  end
end
