# Preview all emails at http://localhost:3000/rails/mailers/post_mailer
class PostMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/post_mailer/new_response
  def new_response
    PostMailer.with(comment: Comment.last, post: Post.last).new_response
  end

end
