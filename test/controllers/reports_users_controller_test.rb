require 'test_helper'

class ReportsUsersControllerTest < ActionController::TestCase
  setup do
    @reports_user = reports_users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:reports_users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create reports_user" do
    assert_difference('ReportsUser.count') do
      post :create, reports_user: { comments: @reports_user.comments, delay_details: @reports_user.delay_details, on_track: @reports_user.on_track, recovery_plan: @reports_user.recovery_plan, report_id: @reports_user.report_id, user_id: @reports_user.user_id, user_report_ready: @reports_user.user_report_ready, vac: @reports_user.vac }
    end

    assert_redirected_to reports_user_path(assigns(:reports_user))
  end

  test "should show reports_user" do
    get :show, id: @reports_user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @reports_user
    assert_response :success
  end

  test "should update reports_user" do
    patch :update, id: @reports_user, reports_user: { comments: @reports_user.comments, delay_details: @reports_user.delay_details, on_track: @reports_user.on_track, recovery_plan: @reports_user.recovery_plan, report_id: @reports_user.report_id, user_id: @reports_user.user_id, user_report_ready: @reports_user.user_report_ready, vac: @reports_user.vac }
    assert_redirected_to reports_user_path(assigns(:reports_user))
  end

  test "should destroy reports_user" do
    assert_difference('ReportsUser.count', -1) do
      delete :destroy, id: @reports_user
    end

    assert_redirected_to reports_users_path
  end
end
