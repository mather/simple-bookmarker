class TagsController < ApplicationController
  before_action :set_tag, only: [:show]
  def index
    @tags = Tag.joins(:bookmarks).eager_load(:bookmarks).group("tags.id").order("count(bookmarks.id) desc")
  end

  def show
    @bookmarks = @tag.bookmarks
  end

private

  def set_tag
    @tag = Tag.find(params[:id])
  end
end
