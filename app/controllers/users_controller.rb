class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.possible_friends_for(current_user.id)
  end

  def show
    @user = User.find(params[:id])
  end
end
