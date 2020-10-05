class Room < ApplicationRecord
	belongs_to :user
  	has_many :posts

  	has_many :subscriptions
  	has_many :users, through: :subscriptions


  	def format_name
	    # the ! after gsub modifies the attribute. Whereas without it just returns it
	    self.name.titleize
	    self.name.gsub!(' ', '')
	end

end
