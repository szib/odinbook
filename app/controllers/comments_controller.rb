class CommentsController < ApplicationController

  # POST /comments
  def create
    @comment = Comment.new(comment_params)
    @comment.post = Post.find(params[:post_id])
    @comment.author = current_user

    @comment.save
    redirect_back(fallback_location: root_path)

    # if @comment.save
    #   redirect_back(fallback_location: root_path)
    # else
    #   render :new
    # end
  end

  private
    # Only allow a trusted parameter "white list" through.
    def comment_params
      params.require(:comment).permit(:content)
    end
end
