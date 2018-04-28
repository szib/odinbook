class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.possible_friends_for(current_user.id)
  end

  def show
    find_user(user_params)
  end

  private

    def user_params
      params.permit(:id)
    end

    def find_user(par)
      @user = User.find(par[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to users_path
    end

end
