require "test_helper"

class PortchargesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get portcharges_new_url
    assert_response :success
  end

  test "should get create" do
    get portcharges_create_url
    assert_response :success
  end
end
