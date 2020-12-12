class CustomDeviseMailer < Devise::Mailer
  protected

  def subject_for(key)
    if key.to_s == 'invitation_instructions'  
      "Hey! You have been invited to BLKroom!"
    else
      return super
    end 
  end
end