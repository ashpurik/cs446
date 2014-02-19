require 'test_helper'

class ConsidersControllerTest < ActionController::TestCase
  setup do
    @consider = considers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:considers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create consider" do
    assert_difference('Consider.count') do
      post :create, consider: {  }
    end

    assert_redirected_to consider_path(assigns(:consider))
  end

  test "should show consider" do
    get :show, id: @consider
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @consider
    assert_response :success
  end

  test "should update consider" do
    patch :update, id: @consider, consider: {  }
    assert_redirected_to consider_path(assigns(:consider))
  end

  test "should destroy consider" do
    assert_difference('Consider.count', -1) do
      session[:consider_id] = @consider.id
      delete :destroy, id: @consider
    end

    assert_redirected_to foster_path
  end

end
