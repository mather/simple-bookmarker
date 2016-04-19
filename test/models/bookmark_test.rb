require 'test_helper'

class BookmarkTest < ActiveSupport::TestCase
  test 'Validate URL format' do
    @bookmark = Bookmark.new(url: "hoge", title: "hoge")
    assert_not @bookmark.valid?
  end

  test 'Search with nil query' do
    @bookmarks = Bookmark.search(nil)
    assert @bookmarks.include?(bookmarks(:two))
  end

  test 'Search with existing query' do
    @bookmarks = Bookmark.search("one")
    assert @bookmarks.include?(bookmarks(:one))
    assert_not @bookmarks.include?(bookmarks(:two))
  end

end
