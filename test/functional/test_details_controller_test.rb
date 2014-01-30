require 'test_helper'

class TestDetailsControllerTest < ActionController::TestCase
  setup do
    @test_detail = test_details(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:test_details)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create test_detail" do
    assert_difference('TestDetail.count') do
      post :create, test_detail: { answer: @test_detail.answer, question_id: @test_detail.question_id, score: @test_detail.score, test_id: @test_detail.test_id }
    end

    assert_redirected_to test_detail_path(assigns(:test_detail))
  end

  test "should show test_detail" do
    get :show, id: @test_detail
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @test_detail
    assert_response :success
  end

  test "should update test_detail" do
    put :update, id: @test_detail, test_detail: { answer: @test_detail.answer, question_id: @test_detail.question_id, score: @test_detail.score, test_id: @test_detail.test_id }
    assert_redirected_to test_detail_path(assigns(:test_detail))
  end

  test "should destroy test_detail" do
    assert_difference('TestDetail.count', -1) do
      delete :destroy, id: @test_detail
    end

    assert_redirected_to test_details_path
  end
end
