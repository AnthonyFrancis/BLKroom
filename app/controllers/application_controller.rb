require 'action_text'

class ApplicationController < ActionController::Base
	helper ActionText::Engine.helpers
	include Pagy::Backend
	before_action :configure_permitted_parameters, if: :devise_controller?
	before_action :find_rooms

	def search
	    q = params[:q]
	    #@room_results  = Room.ransack(name_cont: q).result
	    @post_results = Post.ransack(title_cont: q).result
	    #@user_results = User.ransack(username_cont: q).result
	end

	protected

	def find_rooms
		@rooms = Room.all.order(:title)
 	end

	def configure_permitted_parameters
		added_attrs = [:username, :comment_subscription] # this can grow to however many fields you need
	    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
	    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
	    devise_parameter_sanitizer.permit :accept_invitation, keys: [:email, :username]
	end
end
