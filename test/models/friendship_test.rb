require 'test_helper'

class FriendshipTest < ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods

  def setup
    @user = create(:user)
    @friend = create(:user)
    @new_friend = create(:user)
  end

  def create_and_assert_new_friendship(user = @user, friend = @new_friend)
    create(:friendship, user: user, friend: friend)
    assert user.friend_of? friend
    assert friend.friend_of? user
  end

  test 'should create inverse friendship' do
    assert @user.not_friend_of? @new_friend
    assert @friend.not_friend_of? @new_friend
    assert @new_friend.not_friend_of? @user

    create_and_assert_new_friendship
  end

  test 'should destroy inverse friendship' do
    create_and_assert_new_friendship
    @user.friends.destroy @new_friend
    assert @user.not_friend_of? @new_friend
    assert @new_friend.not_friend_of? @user
  end

  test 'should not add a friend twice' do
    create_and_assert_new_friendship
    assert_raises {
      create(:friendship, user: @user, friend: @new_friend)
    }
  end

  test 'should not add self as a friend' do
    assert_raises {
      create(:friendship, user: @user, friend: @user)
    }
  end

end
