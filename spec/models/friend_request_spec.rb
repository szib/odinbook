require 'rails_helper'

RSpec.describe FriendRequest, type: :model do
  include FactoryBot::Syntax::Methods

  let(:user) { create(:user) }
  let(:friend) { create(:user) }
  let(:new_friend) { create(:user) }

  it 'should add a friend request' do
    expect { user.requested_friends << new_friend }.to change { FriendRequest.count }.from(0).to(1)
  end

  it 'should not add friend request again' do
    user.requested_friends << new_friend
    expect{user.requested_friends << new_friend}.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'should deleting sender user remove request' do
    user.requested_friends << new_friend
    expect { user.destroy }.to change { FriendRequest.count }.from(1).to(0)
  end

  it 'should deleting requested user remove request' do
    user.requested_friends << new_friend
    expect { new_friend.destroy }.to change { FriendRequest.count }.from(1).to(0)
  end

  it 'should not be able to send request to self' do
    expect{user.requested_friends << user}.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'should not add friend request if friend already has sent a request' do
    user.requesting_friends << new_friend
    expect{new_friend.requested_friends << user}.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'should sent request appear in requesting friends too' do
    expect(user.has_sent_friend_request_to?(new_friend)).to be false
    expect(new_friend.has_incoming_friend_request_from?(user)).to be false
    user.requested_friends << new_friend
    expect(user.has_sent_friend_request_to?(new_friend)).to be true
    expect(new_friend.has_incoming_friend_request_from?(user)).to be true
  end



end
