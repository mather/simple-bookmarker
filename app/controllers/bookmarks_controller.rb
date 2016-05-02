require 'open-uri'
require 'timeout'
require 'nokogiri'

class BookmarksController < ApplicationController
  before_action :set_bookmark, only: [:show, :edit, :update, :destroy, :jump]

  # GET /bookmarks
  # GET /bookmarks?q=substring
  # GET /bookmarks.json
  def index
    @bookmarks = Bookmark.search(params[:q])
    @tags = Tag.top(3)
  end

  # GET /bookmarks/1
  # GET /bookmarks/1.json
  def show
  end

  # GET /bookmarks/new
  def new
    @bookmark = Bookmark.new
    gon.available_tags = Tag.all.map(&:name)
  end

  # GET /bookmarks/1/edit
  def edit
    gon.available_tags = Tag.all.map(&:name)
  end

  # POST /bookmarks
  # POST /bookmarks.json
  def create
    @bookmark = Bookmark.new(bookmark_params)

    @bookmark.tags = param_tags

    respond_to do |format|
      if @bookmark.save
        format.html { redirect_to @bookmark, notice: 'Bookmark was successfully created.' }
        format.json { render :show, status: :created, location: @bookmark }
      else
        gon.available_tags = Tag.all.map(&:name)
        format.html { render :new }
        format.json { render json: @bookmark.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bookmarks/1
  # PATCH/PUT /bookmarks/1.json
  def update
    @bookmark.tags = param_tags

    respond_to do |format|
      if @bookmark.update(bookmark_params)
        format.html { redirect_to @bookmark, notice: 'Bookmark was successfully updated.' }
        format.json { render :show, status: :ok, location: @bookmark }
      else
        format.html { render :edit }
        format.json { render json: @bookmark.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bookmarks/1
  # DELETE /bookmarks/1.json
  def destroy
    @bookmark.destroy
    respond_to do |format|
      format.html { redirect_to bookmarks_url, notice: 'Bookmark was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET /bookmarks/1/jump
  def jump
    @bookmark.increment

    respond_to do |format|
      if @bookmark.save
        format.html { redirect_to @bookmark.url, status: 302 }
      else
        format.html { redirect_to :back }
      end
    end
  end

  def fetch_title
    url = params[:url]
    @title = nil
    begin
      Timeout.timeout(10) {
        doc = Nokogiri::HTML(open(url))
        @title = doc.title
      }
    rescue Timeout::Error
      @title = nil
    end
    respond_to do |format|
      format.json { render :get_title }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bookmark
      @bookmark = Bookmark.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bookmark_params
      params.require(:bookmark).permit(:url, :title, :description)
    end

    def param_tags
      if params[:item] and params[:item][:tags]
        tags = Tag.all.to_a
        params[:item][:tags].map { |tag_name|
          tags.detect { |t| t.name == tag_name } || Tag.new(name: tag_name)
        }
      else
        []
      end
    end
end
