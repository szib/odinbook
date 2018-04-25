require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  include FactoryBot::Syntax::Methods

  def setup
    user = create(:user, email: 'test@example.com', password: 'foobar')
    create_list(:user, 8)
    create_list(:friend_request, 2, friend: user)
  end

  test "login and visit friend list" do
    visit users_url
    assert_selector "input", id: 'user_email'
    assert_selector "input", id: 'user_password'
    assert_selector "input", id: 'user_remember_me'
    fill_in 'user_email', with: 'test@example.com'
    fill_in 'user_password', with: 'foobar'
    click_button 'Log in'
    assert_selector 'a', text: 'Find friends'
    click_link 'Find friends'
    assert_selector 'div', class: 'friend-card', count: 10
    assert_selector 'span', class: 'badge-danger', text: '2'
  end
end
