class FriendRequestsController < ApplicationController
  include FriendRequestsHelper

  before_action :authenticate_user!
  before_action { find_friend(friend_request_params) }

  # Send friend request
  def create
    if current_user.has_incoming_friend_request_from?(@friend)
      accept_friend_request(@friend)
    else
      current_user.requested_friends << @friend unless @friend.nil?
    end
    redirect_to users_path
  end

  # Accept friend request
  def update
    accept_friend_request(@friend)
    redirect_to users_path
  end

  # Revoke/refuse friend request
  def destroy
    current_user.requested_friends.delete @friend
    current_user.requesting_friends.delete @friend
    redirect_to users_path
  end

  private

    def friend_request_params
      params.permit(:id)
    end

    def find_friend(par)
      @friend = User.find(par[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to users_path
    end

end
