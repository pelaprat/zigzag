require 'test_helper'

class SearchTagsControllerTest < ActionController::TestCase
  setup do
    @search_tag = search_tags(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:search_tags)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create search_tag" do
    assert_difference('SearchTag.count') do
      post :create, :search_tag => @search_tag.attributes
    end

    assert_redirected_to search_tag_path(assigns(:search_tag))
  end

  test "should show search_tag" do
    get :show, :id => @search_tag.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @search_tag.to_param
    assert_response :success
  end

  test "should update search_tag" do
    put :update, :id => @search_tag.to_param, :search_tag => @search_tag.attributes
    assert_redirected_to search_tag_path(assigns(:search_tag))
  end

  test "should destroy search_tag" do
    assert_difference('SearchTag.count', -1) do
      delete :destroy, :id => @search_tag.to_param
    end

    assert_redirected_to search_tags_path
  end
end
