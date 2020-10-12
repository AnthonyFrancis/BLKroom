class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  belongs_to :parent, optional: true, class_name: "Comment"
  
  validates_presence_of :body

  def comments
    Comment.where(commentable: commentable, parent_id: id)
  end

# Deleting/ Replaceing Comments In Nested Threads Not Working
# 
# Replace belongs_to :user with belongs_to :user, optional: true
#
# def destroy
#   update(user: nil, body: nil)
# end
#
#  def deleted?
#    user.nil?
#  end

end
