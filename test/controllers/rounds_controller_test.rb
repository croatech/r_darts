require 'test_helper'

class RoundsControllerTest < ActionDispatch::IntegrationTest
  test "should get update" do
    get rounds_update_url
    assert_response :success
  end

end
