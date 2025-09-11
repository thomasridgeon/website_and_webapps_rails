require "test_helper"

class BrokerToolkitControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get broker_toolkit_index_url
    assert_response :success
  end

  test "should get create" do
    get broker_toolkit_create_url
    assert_response :success
  end
end
