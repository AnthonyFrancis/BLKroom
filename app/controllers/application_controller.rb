class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?
	before_action :find_rooms

	protected

	def find_rooms
		@rooms = Room.all.order(:title)
 	end

	def configure_permitted_parameters
		added_attrs = [:username] # this can grow to however many fields you need
	    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
	    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
	end
end
