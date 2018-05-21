class FriendRequestsController < ApplicationController
  include FriendRequestsHelper

  before_action :authenticate_user!
  before_action :find_friend, except: [ :index ]

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

  def index
    @pending_friends = current_user.pending_friends
  end

  private

    def friend_request_params
      params.permit(:id)
    end

    def find_friend
      # @friend = User.find(par[:id])
      @friend = User.find(friend_request_params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to users_path
    end

end
