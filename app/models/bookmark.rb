require 'uri'

class Bookmark < ActiveRecord::Base
  validates_uniqueness_of :url
  validates_presence_of :url, :title
  validates_format_of :url, with: URI::regexp
  validates_numericality_of :clicks, greater_than_or_equal_to: 0

  has_and_belongs_to_many :tags

  def increment
    self.clicks += 1
  end
end
