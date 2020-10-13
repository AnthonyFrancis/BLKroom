class AddCachedVotesToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :votes_count, :integer, default: 0
  end
end
