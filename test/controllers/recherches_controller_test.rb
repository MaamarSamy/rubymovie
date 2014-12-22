require 'test_helper'

class RecherchesControllerTest < ActionController::TestCase
  setup do
    @recherch = recherches(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:recherches)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create recherch" do
    assert_difference('Recherche.count') do
      post :create, recherch: {  }
    end

    assert_redirected_to recherch_path(assigns(:recherch))
  end

  test "should show recherch" do
    get :show, id: @recherch
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @recherch
    assert_response :success
  end

  test "should update recherch" do
    patch :update, id: @recherch, recherch: {  }
    assert_redirected_to recherch_path(assigns(:recherch))
  end

  test "should destroy recherch" do
    assert_difference('Recherche.count', -1) do
      delete :destroy, id: @recherch
    end

    assert_redirected_to recherches_path
  end
end
