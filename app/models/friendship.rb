class Friendship < ApplicationRecord
  include Befriendable

  after_create :create_inverse_friendship
  after_destroy :destroy_inverse_friendship

  validates_uniqueness_of :user, scope: :friend,
          message: 'That person is already your friend.'

  private

  def create_inverse_friendship
    friend.friendships.create(friend: user) if friend.friendships.where(friend: user).empty?
  end

  def destroy_inverse_friendship
    fs = friend.friendships.find_by(friend: user)
    fs.destroy if fs
  end

end
