require 'test_helper'

class WorkshopsControllerTest < ActionController::TestCase
  setup do
    @workshop = workshops(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:workshops)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create workshop" do
    assert_difference('Workshop.count') do
      post :create, workshop: { address: @workshop.address, contact_numbers: @workshop.contact_numbers, contact_person: @workshop.contact_person, is_premium: @workshop.is_premium, name: @workshop.name, opening_hours: @workshop.opening_hours, website: @workshop.website }
    end

    assert_redirected_to workshop_path(assigns(:workshop))
  end

  test "should show workshop" do
    get :show, id: @workshop
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @workshop
    assert_response :success
  end

  test "should update workshop" do
    put :update, id: @workshop, workshop: { address: @workshop.address, contact_numbers: @workshop.contact_numbers, contact_person: @workshop.contact_person, is_premium: @workshop.is_premium, name: @workshop.name, opening_hours: @workshop.opening_hours, website: @workshop.website }
    assert_redirected_to workshop_path(assigns(:workshop))
  end

  test "should destroy workshop" do
    assert_difference('Workshop.count', -1) do
      delete :destroy, id: @workshop
    end

    assert_redirected_to workshops_path
  end
end
