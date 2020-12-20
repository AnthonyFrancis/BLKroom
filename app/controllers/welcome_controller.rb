class WelcomeController < ApplicationController
	include Wicked::Wizard
	steps :intro, :post

	def show
	    @user = current_user
	    @rooms = Room.all
	    case step
	    when :post
	      #@user = @user.username
	    end
	    render_wizard
  	end

  	def update
    	@user = current_user
    	@user.attributes = (profile_params)
    	render_wizard @user
  	end

  	private
end
