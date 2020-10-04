class Room < ApplicationRecord
	belongs_to :user
  	has_many :posts

  	has_many :subscriptions
  	has_many :users, through: :subscriptions

  	before_save :format_name

  	def format_name
	    # the ! after gsub modifies the attribute. Whereas without it just returns it
	    self.name.titleize
	    self.name.gsub!(' ', '')
	end

  	acts_as_votable
end
