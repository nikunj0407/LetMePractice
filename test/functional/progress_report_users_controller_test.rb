require 'test_helper'

class ProgressReportUsersControllerTest < ActionController::TestCase
  setup do
    @progress_report_user = progress_report_users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:progress_report_users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create progress_report_user" do
    assert_difference('ProgressReportUser.count') do
      post :create, progress_report_user: {  }
    end

    assert_redirected_to progress_report_user_path(assigns(:progress_report_user))
  end

  test "should show progress_report_user" do
    get :show, id: @progress_report_user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @progress_report_user
    assert_response :success
  end

  test "should update progress_report_user" do
    put :update, id: @progress_report_user, progress_report_user: {  }
    assert_redirected_to progress_report_user_path(assigns(:progress_report_user))
  end

  test "should destroy progress_report_user" do
    assert_difference('ProgressReportUser.count', -1) do
      delete :destroy, id: @progress_report_user
    end

    assert_redirected_to progress_report_users_path
  end
end
