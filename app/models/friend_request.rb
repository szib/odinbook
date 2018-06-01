class FriendRequest < ApplicationRecord
  include Befriendable

  validate :no_incoming_request

  validates_uniqueness_of :user, scope: :friend,
          message: 'You already sent that person a friend request.'

  def no_incoming_request
    if user.has_incoming_friend_request_from?(friend)
      errors.add(:user,
                 "That person has already sent you a friend request.")
    end
  end

end
