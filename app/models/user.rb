class User < ApplicationRecord

  before_create :add_unsubscribe_hash

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  

  has_many :votes

  has_many :subscriptions
  has_many :rooms, through: :subscriptions
  has_many :posts, dependent: :destroy

  validates_uniqueness_of :username
  validates_presence_of :username

  has_many :subscribed_posts, through: :rooms, source: :posts

  extend FriendlyId
  friendly_id :username, use: :slugged

  def should_generate_new_friendly_id?
    username_changed?
  end

  def votes?(post)
    post.votes.where(user_id: id).any?
  end

  private

  def add_unsubscribe_hash
    self.unsubscribe_hash = SecureRandom.hex
  end

end
