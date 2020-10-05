class CommentsController < ApplicationController
  before_action :authenticate_user!
  respond_to :js, :html, :json


  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @commentable
    else
      redirect_to @commentable, alert: "Something went wrong"
    end
  end

  def destroy
    @comment = @commentable.comments.find(params[:id])
    @comment.destroy

    redirect_to @commentable
  end

  def vote
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if params[:format] == "vote"
        @comment.liked_by current_user
      elsif params[:format] == "unvote"
        @comment.unliked_by current_user
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :parent_id)
  end

end
