class Room < ApplicationRecord
	belongs_to :user
  	has_many :posts

  	acts_as_votable
end
