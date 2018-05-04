class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  # GET /comments
  # def index
  #   @comments = Comment.all
  # end
  #
  # # GET /comments/1
  # def show
  # end

  # GET /comments/new
  def new
    # @post 
    @comment = Comment.new(author: current_user, post: @post)
  end

  # GET /comments/1/edit
  # def edit
  # end

  # POST /comments
  def create
    redirect_back(fallback_location: root_path)
    # @comment = Comment.new(comment_params)
    #
    # if @comment.save
    #   redirect_to @comment, notice: 'Comment was successfully created.'
    # else
    #   render :new
    # end
  end

  # PATCH/PUT /comments/1
  # def update
  #   if @comment.update(comment_params)
  #     redirect_to @comment, notice: 'Comment was successfully updated.'
  #   else
  #     render :edit
  #   end
  # end

  # DELETE /comments/1
  def destroy
    # @comment.destroy
    redirect_to comments_url, notice: 'Comment was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def comment_params
      params.fetch(:comment, {})
    end
end
