require "test_helper"

class Blog::SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get blog_sessions_new_url
    assert_response :success
  end

  test "should get create" do
    get blog_sessions_create_url
    assert_response :success
  end

  test "should get destroy" do
    get blog_sessions_destroy_url
    assert_response :success
  end
end
