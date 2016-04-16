class SetClickCountDefaultToBookmark < ActiveRecord::Migration
  def change
    change_column_default :bookmarks, :clicks, 0
  end
end
