require 'test_helper'

class QuestionwiseMarksDistributionsControllerTest < ActionController::TestCase
  setup do
    @questionwise_marks_distribution = questionwise_marks_distributions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:questionwise_marks_distributions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create questionwise_marks_distribution" do
    assert_difference('QuestionwiseMarksDistribution.count') do
      post :create, questionwise_marks_distribution: { question_type: @questionwise_marks_distribution.question_type }
    end

    assert_redirected_to questionwise_marks_distribution_path(assigns(:questionwise_marks_distribution))
  end

  test "should show questionwise_marks_distribution" do
    get :show, id: @questionwise_marks_distribution
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @questionwise_marks_distribution
    assert_response :success
  end

  test "should update questionwise_marks_distribution" do
    put :update, id: @questionwise_marks_distribution, questionwise_marks_distribution: { question_type: @questionwise_marks_distribution.question_type }
    assert_redirected_to questionwise_marks_distribution_path(assigns(:questionwise_marks_distribution))
  end

  test "should destroy questionwise_marks_distribution" do
    assert_difference('QuestionwiseMarksDistribution.count', -1) do
      delete :destroy, id: @questionwise_marks_distribution
    end

    assert_redirected_to questionwise_marks_distributions_path
  end
end
