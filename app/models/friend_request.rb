class FriendRequest < ApplicationRecord
  include Befriendable

  validate :not_friends
  validate :no_incoming_request

  def not_friends
    if user.friend_of?(friend)
      errors.add(:friend, "#{friend.profile.full_name} is already your friend...")
    end
  end

  def no_incoming_request
    if user.requesting_friends.include?(friend)
      errors.add(:friend,
                 "#{friend.profile.full_name} has already sent you a friend request.")
    end
  end

end
