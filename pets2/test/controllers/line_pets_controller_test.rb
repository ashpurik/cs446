require 'test_helper'

class LinePetsControllerTest < ActionController::TestCase
  setup do
    @line_pet = line_pets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:line_pets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create line_pet" do
    assert_difference('LinePet.count') do
      post :create, pet_id: pets(:ruby).id
    end

    assert_redirected_to foster_path
  end

  test "should show line_pet" do
    get :show, id: @line_pet
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @line_pet
    assert_response :success
  end

  test "should update line_pet" do
    patch :update, id: @line_pet, line_pet: { pet_id: @line_pet.pet_id }
    assert_redirected_to line_pet_path(assigns(:line_pet))
  end

  test "should destroy line_pet" do
    assert_difference('LinePet.count', -1) do
      delete :destroy, id: @line_pet
    end

    assert_redirected_to line_pets_path
  end

  test "should create line_pet via ajax" do
    assert_difference('LinePet.count') do
      xhr :post, :create, pet_id: pets(:ruby).id
    end 

    assert_response :success
#    assert_select_jquery :html, '#consider' do
#      assert_select 'tr#current_item td', /Programming Ruby 1.9/
#    end
  end

end
