require "test_helper"

class ImsControllerTest < ActionDispatch::IntegrationTest
  test "should get main" do
    get ims_main_url
    assert_response :success
  end
end
