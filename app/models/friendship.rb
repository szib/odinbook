class Friendship < ApplicationRecord
  after_create :create_inverse_friendship
  after_destroy :destroy_inverse_friendship

  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validates_presence_of :user, :friend
  validates_uniqueness_of :user, scope: :friend

  private

  def create_inverse_friendship
    friend.friendships.create(friend: user) if friend.friendships.where(friend: user).empty?
  end

  def destroy_inverse_friendship
    fs = friend.friendships.find_by(friend: user)
    fs.destroy if fs
  end

end
