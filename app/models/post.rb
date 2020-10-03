class Post < ApplicationRecord
	mount_uploader :post_image, PostImageUploader
	belongs_to :user

	validates :title, presence: true
	validates :body, length: { maximum: 8000 }
	validates :url, url: true, allow_blank: true
end
