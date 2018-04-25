require 'test_helper'

class FriendRequestTest < ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods

  def setup
    @user = create(:user)
    @friend = create(:user)
    @new_friend = create(:user)
  end

  test 'should add a friend request' do
    assert_difference 'FriendRequest.count', 1 do
      @user.requested_friends << @new_friend
    end
  end

  test 'should sent request appear in requesting friends too' do
    assert @user.requesting_friends.exclude? @new_friend
    assert @new_friend.requested_friends.exclude? @user
    @user.requested_friends << @new_friend
    assert @new_friend.requesting_friends.include? @user
    assert @user.requested_friends.include? @new_friend
  end

  test 'should not add friend request again' do
    @user.requested_friends << @new_friend
    assert_raise ActiveRecord::RecordInvalid do
      @user.requested_friends << @new_friend
    end
  end

  test 'should not add friend request if friend already has sent a request' do
    @user.requesting_friends << @new_friend
    assert_raise  ActiveRecord::RecordInvalid do
      @new_friend.requested_friends << @user
    end
  end

  test 'should deleting sender user remove request' do
    @user.requested_friends << @new_friend
    assert_difference 'FriendRequest.count', -1 do
      @user.destroy
    end
  end

  test 'should deleting requested user remove request' do
    @user.requested_friends << @new_friend
    assert_difference 'FriendRequest.count', -1 do
      @new_friend.destroy
    end
  end

  test 'should not be able to send request to self' do
    assert_raise do
      @user.requested_friends << @user
    end
  end

end
