class User < ApplicationRecord

  before_create :add_unsubscribe_hash

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  
  has_many :comments, dependent: :destroy

  has_many :votes, dependent: :destroy

  has_many :subscriptions, dependent: :destroy
  has_many :rooms, through: :subscriptions, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :invitations, class_name: self.to_s, as: :invited_by

  validates_uniqueness_of :username
  validates_presence_of :username
  validates_presence_of :first_name
  validates_presence_of :last_name

  has_many :subscribed_posts, through: :rooms, source: :posts, dependent: :destroy

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

  #protected
  #  def confirmation_required?
  #    false
  #  end

end
