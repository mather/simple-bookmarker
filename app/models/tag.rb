class Tag < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name

  has_and_belongs_to_many :bookmarks

  def self.top(n)
    Tag.joins(:bookmarks).group("tags.id").order("count(tags.id) desc").limit(n)
  end

  def self.destroy_if_empty
    Tag.where(Tag.arel_table[:id].not_in(Tag.joins(:bookmarks).map{|t| t.id })).each do |tag|
      tag.destroy
    end
  end
end
