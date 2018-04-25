require 'test_helper'

class FriendsControllerTest < ActionDispatch::IntegrationTest
  test "index should render" do
    get friends_url
    assert_redirected_to new_user_session_path
  end
end
