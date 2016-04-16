class CreateBookmarks < ActiveRecord::Migration
  def change
    create_table :bookmarks do |t|
      t.string :url
      t.string :title
      t.text :description
      t.integer :clicks

      t.timestamps null: false
    end
  end
end
