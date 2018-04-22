class FriendRequest < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validates_presence_of :user, :friend
  validates_uniqueness_of :user, scope: :friend,
              message: 'You have an incoming friend request from this person.'
end
