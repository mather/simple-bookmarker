require 'test_helper'

class TagsControllerTest < ActionController::TestCase
  setup do
    @tag = tags(:tag1)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tags)
  end

  test "should get show" do
    get :show, id: @tag.id
    assert_response :success
    assert_not_nil assigns(:tag)
    assert_not_nil assigns(:bookmarks)
  end

end
