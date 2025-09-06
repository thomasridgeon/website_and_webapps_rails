require "test_helper"

class SolarbenefitsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get solarbenefits_index_url
    assert_response :success
  end
end
