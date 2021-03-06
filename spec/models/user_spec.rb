require 'rails_helper'

RSpec.describe User, type: :model do

  subject(:user) { build(:user) }
  let(:friend) { create(:user) }

  it { is_expected.to be_valid }

  it 'should be invalid without email' do
    user.email = nil
    expect(user).to_not be_valid
  end

  it 'should have a password' do
    user.password = nil
    expect(user).to_not be_valid
  end

  it 'should have at least 6 chr long password' do
    user.password = 'aaaaa'
    expect(user).to_not be_valid
    user.password = 'aaaaaa'
    expect(user).to be_valid
  end

  it 'should be not valid without valid profile' do
    user.profile = nil
    expect(user).to_not be_valid
  end

  it 'email address should be unique' do
    create(:user, email: 'test@example.com')
    dup_user = build(:user, email: 'tesT@exAmple.Com')
    expect(dup_user).to_not be_valid
  end

  it 'should return friends_ids' do
    create(:friendship, user: user, friend: friend)
    list = create_list(:friendship, 5, user: user)
    expect(user.friends_ids).to include user.id
    expect(user.friends_ids).to include friend.id
    expect(user.friends_ids.length).to be 7
  end

  it 'should return timeline posts' do
    #TODO write test
  end

  it 'should return number of incoming friend requests' do
    4.times { create(:friend_request, friend: user) }
    expect(user.number_of_friend_requests).to be 4
  end

  context 'when user has no friends' do
    it 'friend_of?(another_user) should return false' do
      expect(user).to_not be_friend_of(friend)
    end

    it 'not_friend_of?(another_user) should return true' do
      expect(user).to be_not_friend_of(friend)
    end
  end

  context 'when has friends' do
    before { create(:friendship, user: user, friend: friend) }

    it 'friend_of?(another_user) should return true' do
      expect(user).to be_friend_of(friend)
    end

    it 'not_friend_of?(another_user) should return false' do
      expect(user).to_not be_not_friend_of(friend)
    end
  end

  context 'when has no incoming friend request from another user' do
    it 'has_pending_friend_request? should return false' do
      expect(user.has_pending_friend_request?(friend)).to be false
    end

    it 'has_incoming_friend_request_from? should return false' do
      expect(user.has_incoming_friend_request_from?(friend)).to be false
    end

    it 'has_sent_friend_request_to? should return false' do
      expect(user.has_sent_friend_request_to?(friend)).to be false
    end
  end

  context 'when has sent friend request to another user' do
    before { create(:friend_request, user: user, friend: friend) }

    it 'has_pending_friend_request? should return false' do
      expect(user.has_pending_friend_request?(friend)).to be true
    end

    it 'has_incoming_friend_request_from? should return false' do
      expect(user.has_incoming_friend_request_from?(friend)).to be false
    end

    it 'has_sent_friend_request_to? should return false' do
      expect(user.has_sent_friend_request_to?(friend)).to be true
    end
  end

  context 'when has incoming friend request to another user' do
    before { create(:friend_request, user: friend, friend: user) }

    it 'has_pending_friend_request? should return false' do
      expect(user.has_pending_friend_request?(friend)).to be true
    end

    it 'has_incoming_friend_request_from? should return false' do
      expect(user.has_incoming_friend_request_from?(friend)).to be true
    end

    it 'has_sent_friend_request_to? should return false' do
      expect(user.has_sent_friend_request_to?(friend)).to be false
    end
  end

  context 'listing possible friends' do
    let (:users) { create_list(:user, 3) }
    it 'does not include the current user' do
      expect(User.possible_friends_of(users[0])).to_not include(users[0])
    end
    it 'does not include friends' do
      Friendship.create(user: users[0], friend: users[1])
      expect(User.possible_friends_of(users[0])).to_not include(users[1])
    end
    it 'does include not friends' do
      expect(User.possible_friends_of(users[0])).to include(users[2])
    end

  end
end
