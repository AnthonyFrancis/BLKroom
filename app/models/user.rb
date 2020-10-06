class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :subscriptions
  has_many :rooms, through: :subscriptions
  has_many :posts, dependent: :destroy

  validates_uniqueness_of :username
  validates_presence_of :username

  has_many :subscribed_posts, through: :rooms, source: :posts

  acts_as_voter


  extend FriendlyId
  friendly_id :username, use: :slugged

  def should_generate_new_friendly_id?
    username_changed?
  end
  
end
