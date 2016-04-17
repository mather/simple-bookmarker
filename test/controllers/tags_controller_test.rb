require 'test_helper'

class TagsControllerTest < ActionController::TestCase
  setup do
    @tag = tags(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get show" do
    get :show, id: @tag.id
    assert_response :success
  end

end
