require 'test_helper'

class BookmarksControllerTest < ActionController::TestCase
  setup do
    @bookmark = bookmarks(:bookmark1)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bookmarks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bookmark with another URL" do
    assert_difference('Bookmark.count', 1) do
      post :create, bookmark: { description: @bookmark.description, title: @bookmark.title, url: @bookmark.url + "?hoge=hoge" }, item: { tags: ["hoge"] }
    end

    assert_redirected_to bookmark_path(assigns(:bookmark))
  end

  test "should fail to create bookmark with existing URL" do
    assert_no_difference 'Bookmark.count' do
      post :create, bookmark: { description: @bookmark.description, title: @bookmark.title, url: @bookmark.url }, item: { tags: ["hoge", "fuga"] }
    end
  end

  test "should show bookmark" do
    get :show, id: @bookmark
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bookmark
    assert_response :success
  end

  test "should update bookmark" do
    patch :update, id: @bookmark, bookmark: { clicks: @bookmark.clicks, description: @bookmark.description, title: @bookmark.title, url: @bookmark.url }, item: { tags: ["hoge"] }
    assert_redirected_to bookmark_path(assigns(:bookmark))
  end

  test "should destroy bookmark" do
    assert_difference('Bookmark.count', -1) do
      delete :destroy, id: @bookmark
    end

    assert_redirected_to bookmarks_path
  end

  test "should jump bookmark with countup" do
    assert_difference("Bookmark.find(@bookmark.id).clicks") do
      get :jump, id: @bookmark
    end
    assert_redirected_to @bookmark.url
  end
end
