require "test_helper"

class Journal::LandingControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get journal_landing_index_url
    assert_response :success
  end
end
