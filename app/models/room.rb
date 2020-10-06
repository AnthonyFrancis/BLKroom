class Room < ApplicationRecord
	belongs_to :user
  	has_many :posts

  	has_many :subscriptions
  	has_many :users, through: :subscriptions

  	extend FriendlyId
  	friendly_id :title, use: :slugged

  	def should_generate_new_friendly_id?
   		title_changed?
  	end

  	def format_name
	    # the ! after gsub modifies the attribute. Whereas without it just returns it
	    self.name.titleize
	    self.name.gsub!(' ', '')
	end

end
