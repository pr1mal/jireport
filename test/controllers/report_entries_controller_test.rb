require 'test_helper'

class ReportEntriesControllerTest < ActionController::TestCase
  setup do
    @report_entry = report_entries(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:report_entries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create report_entry" do
    assert_difference('ReportEntry.count') do
      post :create, report_entry: { ended_at: @report_entry.ended_at, eta: @report_entry.eta, issues: @report_entry.issues, msproject_task_completion_date: @report_entry.msproject_task_completion_date, percentage: @report_entry.percentage, project: @report_entry.project, report_id: @report_entry.report_id, risk_mitigation_plans: @report_entry.risk_mitigation_plans, started_at: @report_entry.started_at, status: @report_entry.status, task_desc: @report_entry.task_desc, task_id: @report_entry.task_id, user_id: @report_entry.user_id }
    end

    assert_redirected_to report_entry_path(assigns(:report_entry))
  end

  test "should show report_entry" do
    get :show, id: @report_entry
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @report_entry
    assert_response :success
  end

  test "should update report_entry" do
    patch :update, id: @report_entry, report_entry: { ended_at: @report_entry.ended_at, eta: @report_entry.eta, issues: @report_entry.issues, msproject_task_completion_date: @report_entry.msproject_task_completion_date, percentage: @report_entry.percentage, project: @report_entry.project, report_id: @report_entry.report_id, risk_mitigation_plans: @report_entry.risk_mitigation_plans, started_at: @report_entry.started_at, status: @report_entry.status, task_desc: @report_entry.task_desc, task_id: @report_entry.task_id, user_id: @report_entry.user_id }
    assert_redirected_to report_entry_path(assigns(:report_entry))
  end

  test "should destroy report_entry" do
    assert_difference('ReportEntry.count', -1) do
      delete :destroy, id: @report_entry
    end

    assert_redirected_to report_entries_path
  end
end