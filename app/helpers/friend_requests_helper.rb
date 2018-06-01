module FriendRequestsHelper

  def accept_friend_request(friend)
    ActiveRecord::Base.transaction do
      current_user.requested_friends.delete friend
      current_user.requesting_friends.delete friend
      current_user.friends << friend
    end
  end

end
