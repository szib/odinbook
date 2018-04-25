require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "index should redirect to sign_in" do
    get users_index_url
    assert_redirected_to new_user_session_path
  end

  test "show should redirect to sign_in" do
    get users_show_url
    assert_redirected_to new_user_session_path
  end

end
