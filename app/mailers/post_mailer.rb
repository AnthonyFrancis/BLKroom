class PostMailer < ApplicationMailer

  default from: "notifications@blkroom.net"

  def new_response
    @comment = params[:comment]
    @post = params[:post]

    mail to: @comment.user.email, subject: "New response on: #{@comment.body}"    
  end
end
