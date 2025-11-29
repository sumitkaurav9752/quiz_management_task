require "test_helper"

class QuizSubmissionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get quiz_submissions_index_url
    assert_response :success
  end

  test "should get show" do
    get quiz_submissions_show_url
    assert_response :success
  end
end
