class AddPostsUser < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :tweet_sender, :string
  end
end
