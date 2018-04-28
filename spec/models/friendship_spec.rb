require 'rails_helper'

RSpec.describe Friendship, type: :model do

  let(:user) { create(:user) }
  let(:friend) { create(:user) }
  let(:new_friend) { create(:user) }
  let(:friendship) { create(:friendship, user: user, friend: friend) }

  it 'creates inverse friendship' do
    create(:friendship, user: user, friend: friend)
    expect(user).to be_friend_of(friend)
    expect(friend).to be_friend_of(user)
  end

  describe 'destroy inverse friendship' do
    it 'when user has been deleted' do
      create(:friendship, user: user, friend: friend)
      user.destroy
      expect(friend).to_not be_friend_of(user)
    end

    it 'when friend has been deleted' do
      create(:friendship, user: user, friend: friend)
      friend.destroy
      expect(user).to_not be_friend_of(friend)
    end

    it 'when friendship has been deleted' do
      fr = create(:friendship, user: user, friend: friend)
      expect(user).to be_friend_of(friend)
      expect(friend).to be_friend_of(user)
      fr.destroy
      expect(user).to_not be_friend_of(friend)
      expect(friend).to_not be_friend_of(user)
    end
  end


end
