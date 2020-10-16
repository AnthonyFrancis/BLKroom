class PostMailer < ApplicationMailer

  default from: "notification@blkroom.net"

  def new_response
    @comment = params[:comment]
    @post = params[:post]

    if @comment.user.comment_subscription?
      mail to: @comment.user.email, subject: "New response on: #{@comment.body}"
    end    
  end
end
