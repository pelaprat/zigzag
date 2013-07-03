require 'test_helper'

class TermingsControllerTest < ActionController::TestCase
  setup do
    @terming = termings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:termings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create terming" do
    assert_difference('Terming.count') do
      post :create, :terming => @terming.attributes
    end

    assert_redirected_to terming_path(assigns(:terming))
  end

  test "should show terming" do
    get :show, :id => @terming.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @terming.to_param
    assert_response :success
  end

  test "should update terming" do
    put :update, :id => @terming.to_param, :terming => @terming.attributes
    assert_redirected_to terming_path(assigns(:terming))
  end

  test "should destroy terming" do
    assert_difference('Terming.count', -1) do
      delete :destroy, :id => @terming.to_param
    end

    assert_redirected_to termings_path
  end
end
