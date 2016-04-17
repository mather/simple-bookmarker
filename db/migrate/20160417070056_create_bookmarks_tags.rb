class CreateBookmarksTags < ActiveRecord::Migration
  def change
    create_table :bookmarks_tags do |t|
      t.integer :bookmark_id
      t.integer :tag_id

      t.index [:bookmark_id, :tag_id], unique: true
    end
  end
end
