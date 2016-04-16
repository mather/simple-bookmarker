class ChangeColumnToBookmark < ActiveRecord::Migration
  def change
    change_column :bookmarks, :url, :string, null: false, unique: true
    change_column :bookmarks, :title, :string, null: false
    change_column_default :bookmarks, :clicks, 0
  end
end
