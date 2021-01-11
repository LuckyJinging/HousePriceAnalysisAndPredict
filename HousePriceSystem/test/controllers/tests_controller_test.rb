require 'test_helper'

class TestsControllerTest < ActionDispatch::IntegrationTest
  test "should get mytest" do
    get tests_mytest_url
    assert_response :success
  end

end
