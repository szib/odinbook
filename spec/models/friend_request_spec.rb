require 'rails_helper'

RSpec.describe FriendRequest, type: :model do
  include FactoryBot::Syntax::Methods

  let(:user) { create(:user) }
  let(:friend) { create(:user) }
  let(:new_friend) { create(:user) }

  it 'should add a friend request' do
    expect{create(:friend_request, user: user, friend: new_friend)}.to change { FriendRequest.count }.from(0).to(1)
  end

  it 'should not add friend request again' do
    create(:friend_request, user: user, friend: friend)
    expect{create(:friend_request, user: user, friend: friend)}.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'should deleting sender user remove request' do
    create(:friend_request, user: user, friend: friend)
    expect { user.destroy }.to change { FriendRequest.count }.from(1).to(0)
  end

  it 'should deleting requested user remove request' do
    create(:friend_request, user: user, friend: new_friend)
    expect { new_friend.destroy }.to change { FriendRequest.count }.from(1).to(0)
  end

  it 'should not be able to send request to self' do
    expect{create(:friend_request, user: user, friend: user)}.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'should not add friend request if friend already has sent a request' do
    create(:friend_request, user: user, friend: new_friend)
    fr = build(:friend_request, user: new_friend, friend: user)
    expect(fr).to_not be_valid
    expect(fr.errors.messages).to be_has_key(:user)
  end

  it 'should fail if friend had already sent a friend request' do
    create(:friend_request, user: friend, friend: user)
    fr = build(:friend_request, user: user, friend: friend)
    expect(fr).to_not be_valid
    expect(fr.errors.messages).to be_has_key(:user)
  end

  it 'should sent request appear in requesting friends too' do
    expect(user.has_sent_friend_request_to?(new_friend)).to be false
    expect(new_friend.has_incoming_friend_request_from?(user)).to be false
    create(:friend_request, user: user, friend: new_friend)
    expect(user.has_sent_friend_request_to?(new_friend)).to be true
    expect(new_friend.has_incoming_friend_request_from?(user)).to be true
  end

end
