require 'test_helper'

class UsersTest < ActionDispatch::IntegrationTest
  test 'visit all users redirects' do
    get users_path
    assert_redirected_to new_user_session_path
    follow_redirect!
    assert_select 'li', text: 'You need to sign in or sign up before continuing.'
    assert_select 'input', name: 'user[email]'
    assert_select 'input', name: 'user[password]'
  end
end
