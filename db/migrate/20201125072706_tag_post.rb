class TagPost < ActiveRecord::Migration[5.2]
  def change
    drop_table :tag_posts
  end
end
