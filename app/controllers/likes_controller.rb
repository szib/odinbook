class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_likeable
  before_action :set_like, only: :destroy

  # POST /likes
  def create
    unless @likeable.nil?
      @like = Like.new
      @like.user = current_user
      @like.likeable = @likeable
      @like.save
    end
    redirect_back(fallback_location: root_path)
  end

  # DELETE /likes/1
  def destroy
    @like.destroy unless @like.nil?
    redirect_back(fallback_location: root_path)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_like
      @like = @likeable.likes.where(user: current_user).first
    end

    def find_likeable
      if params[:post_id]
        @likeable = Post.find(params[:post_id])
      else
        @likeable = Comment.find(params[:comment_id])
      end
    end

    # Only allow a trusted parameter "white list" through.
    # def like_params
    #   params.fetch(:like, {})
    # end
end
