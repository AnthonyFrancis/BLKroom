class Post < ApplicationRecord
	#include VoteCountable
	mount_uploader :post_image, PostImageUploader
	mount_uploader :post_video, PostVideoUploader

	belongs_to :user
	belongs_to :room

	validates :title, presence: true
	validates :body, length: { maximum: 8000 }
	validates :url, url: true, allow_blank: true
	validate :image_or_video
	validate :url_or_content



	acts_as_votable

	private

	def image_or_video
		unless post_image.blank? || post_video.blank?
			unless post_image.blank? ^ post_video.blank?
				errors.add(:base, "Add an image or video, not both")
			end
		end
	end

	def url_or_content
		unless url.blank? || body.blank?
			unless url.blank? ^ body.blank?
				errors.add(:base, "Add an valid URL or text content")
			end
		end
	end
end
