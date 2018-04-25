class FriendRequestsController < ApplicationController
  before_action :authenticate_user!
  before_action { @friend = User.find(params[:id]) }

  # Send friend request
  def create
    current_user.requested_friends << @friend
    redirect_to users_path
  end

  # Accept friend request
  def update
    ActiveRecord::Base.transaction do
      current_user.requested_friends.delete @friend
      current_user.requesting_friends.delete @friend
      current_user.friends << @friend
    end
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

end
