class Posts::VotesController < ApplicationController
	before_action :authenticate_user!
	before_action :set_post
	
	def create
		@post.votes.where(user_id: current_user.id).first_or_create

		respond_to do |format|
	      format.html { redirect_to request.referrer }
	    end
	end

	def destroy
		@post.votes.where(user_id: current_user.id).destroy_all

		respond_to do |format|
	      format.html { redirect_to request.referrer }
	    end
	end

	private

	def set_post
      @post = Post.friendly.find(params[:post_id])
    end
end