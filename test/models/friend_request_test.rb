require 'test_helper'

class FriendRequestTest < ActiveSupport::TestCase

  def setup
    @miyamoto = users(:miyamoto)
    @tomoe = users(:tomoe)
    @gennosuke = users(:gennosuke)
    @nakamura = users(:nakamura)
  end

  test 'should add a friend request' do
    assert_difference 'FriendRequest.count', 1 do
      @gennosuke.requested_friends << @nakamura
    end
  end

  test 'should sent request appear in requesting friends too' do
    assert @nakamura.requesting_friends.exclude? @gennosuke
    assert @gennosuke.requested_friends.exclude? @nakamura
    @gennosuke.requested_friends << @nakamura
    assert @nakamura.requesting_friends.include? @gennosuke
    assert @gennosuke.requested_friends.include? @nakamura
  end

  test 'should not add friend request again' do
    @gennosuke.requested_friends << @nakamura
    assert_raise ActiveRecord::RecordInvalid do
      @gennosuke.requested_friends << @nakamura
    end
  end

  test 'should not add friend request if friend already has sent a request' do
    @nakamura.requesting_friends << @gennosuke
    assert_raise  ActiveRecord::RecordInvalid do
      @gennosuke.requested_friends << @nakamura
    end
  end

  test 'should deleting sender user remove request' do
    @nakamura.requested_friends << @gennosuke
    assert_difference 'FriendRequest.count', -3 do # @nakamura has 3 pending FR
      @nakamura.destroy
    end
  end

  test 'should deleting requested user remove request' do
    @nakamura.requested_friends << @gennosuke
    assert_difference 'FriendRequest.count', -1 do
      @gennosuke.destroy
    end
  end

  test 'should not be able to send request to self' do
    assert_raise do
      @nakamura.requested_friends << @nakamura
    end
  end

end
