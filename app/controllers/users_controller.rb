class UsersController < ApplicationController
	def show
    	@user = User.friendly.find(params[:id])
  	end

  	def create
	   @invite = Invite.new(invite_params) # Make a new Invite
	   @invite.sender_id = current_user.id # set the sender to the current user
	   if @invite.save
	      InviteMailer.new_user_invite(@invite, new_user_registration_path(:invite_token => @invite.token)).deliver #send the invite data to our mailer to deliver the email
	   else
	      # oh no, creating an new invitation failed
	   end
	end
end
