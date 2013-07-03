require 'test_helper'

class SearchAuthorsControllerTest < ActionController::TestCase
  setup do
    @search_author = search_authors(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:search_authors)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create search_author" do
    assert_difference('SearchAuthor.count') do
      post :create, :search_author => @search_author.attributes
    end

    assert_redirected_to search_author_path(assigns(:search_author))
  end

  test "should show search_author" do
    get :show, :id => @search_author.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @search_author.to_param
    assert_response :success
  end

  test "should update search_author" do
    put :update, :id => @search_author.to_param, :search_author => @search_author.attributes
    assert_redirected_to search_author_path(assigns(:search_author))
  end

  test "should destroy search_author" do
    assert_difference('SearchAuthor.count', -1) do
      delete :destroy, :id => @search_author.to_param
    end

    assert_redirected_to search_authors_path
  end
end
