class Tag < ActiveRecord::Base
  validates_presence_of :name

  has_and_belongs_to_many :bookmarks

  def self.top(n)
    Tag.joins(:bookmarks).group("tags.id").order("count(tags.id) desc").limit(n)
  end
end
