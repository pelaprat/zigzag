require 'test_helper'

class AuthorTermsControllerTest < ActionController::TestCase
  setup do
    @author_term = author_terms(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:author_terms)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create author_term" do
    assert_difference('AuthorTerm.count') do
      post :create, :author_term => @author_term.attributes
    end

    assert_redirected_to author_term_path(assigns(:author_term))
  end

  test "should show author_term" do
    get :show, :id => @author_term.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @author_term.to_param
    assert_response :success
  end

  test "should update author_term" do
    put :update, :id => @author_term.to_param, :author_term => @author_term.attributes
    assert_redirected_to author_term_path(assigns(:author_term))
  end

  test "should destroy author_term" do
    assert_difference('AuthorTerm.count', -1) do
      delete :destroy, :id => @author_term.to_param
    end

    assert_redirected_to author_terms_path
  end
end
