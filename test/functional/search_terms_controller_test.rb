require 'test_helper'

class SearchTermsControllerTest < ActionController::TestCase
  setup do
    @search_term = search_terms(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:search_terms)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create search_term" do
    assert_difference('SearchTerm.count') do
      post :create, :search_term => @search_term.attributes
    end

    assert_redirected_to search_term_path(assigns(:search_term))
  end

  test "should show search_term" do
    get :show, :id => @search_term.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @search_term.to_param
    assert_response :success
  end

  test "should update search_term" do
    put :update, :id => @search_term.to_param, :search_term => @search_term.attributes
    assert_redirected_to search_term_path(assigns(:search_term))
  end

  test "should destroy search_term" do
    assert_difference('SearchTerm.count', -1) do
      delete :destroy, :id => @search_term.to_param
    end

    assert_redirected_to search_terms_path
  end
end
