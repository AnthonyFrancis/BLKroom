# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
  :user_name => 'apikey',
  :password => 'your_sendgrid_api_key',
  :domain => 'blkroom-dev.herokuapp.com',
  :address => 'smtp.sendgrid.net',
  :port => 3000,
  :authentication => :plain,
  :enable_starttls_auto => true
}