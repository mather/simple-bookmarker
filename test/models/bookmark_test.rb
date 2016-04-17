require 'test_helper'

class BookmarkTest < ActiveSupport::TestCase
  test 'Validate URL format' do
    @bookmark = Bookmark.new(url: "hoge", title: "hoge")
    assert_not @bookmark.valid?
  end
end
