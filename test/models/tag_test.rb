require 'test_helper'

class TagTest < ActiveSupport::TestCase
  test "Raise exception if not present" do
    assert_raises(Exception) { Tag.new("") }
  end

  test "Tag count" do
    assert_equal Tag.count, 4
  end

  test "Get top 3 tags" do
    #p Tag.top(3).explain
    top3_tags = Tag.top(3).take(3)
    assert_not top3_tags.select { |t| t.name == tags(:tag1).name }.empty?, "tag1 should be included in top 3"
    assert top3_tags.select { |t| t.name == tags(:tag4).name }.empty?, "tag4 should not be included in top 3"
  end
end
