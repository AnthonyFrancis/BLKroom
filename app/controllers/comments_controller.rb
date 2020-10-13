class CommentsController < ApplicationController
  before_action :authenticate_user!
  respond_to :js, :html, :json


  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      PostMailer.with(comment: @comment, post: @post).new_response.deliver_now
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

  private

  def comment_params
    params.require(:comment).permit(:body, :parent_id)
  end

end
