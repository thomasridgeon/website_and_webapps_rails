require "test_helper"

class SolardcalculatorControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get solardcalculator_new_url
    assert_response :success
  end

  test "should get create" do
    get solardcalculator_create_url
    assert_response :success
  end
end
