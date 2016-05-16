class TagsController < ApplicationController
  before_action :set_tag, only: [:show]
  def index
    @tags = Tag.joins(:bookmarks).select("tags.*, count(bookmarks.id) as bookmarks_count").group("tags.id").order("bookmarks_count desc").page(params[:page])
  end

  def show
    @bookmarks = @tag.bookmarks.page(params[:page])
  end

private

  def set_tag
    @tag = Tag.find(params[:id])
  end
end
