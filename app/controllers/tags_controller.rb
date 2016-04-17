class TagsController < ApplicationController
  before_action :set_tag, only: [:show]
  def index
    @tags = Tag.eager_load(:bookmarks).all
  end

  def show
  end

private

  def set_tag
    @tag = Tag.find(params[:id])
  end
end
