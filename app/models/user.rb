class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :role, :stripe_customer_token, :shared_wikis, :avatar, :votes
  has_one :subscription, dependent: :destroy
  has_one :wiki
  has_many :votes, dependent: :destroy
  has_many :friendships
  has_many :friends, through: :friendships
  has_many :inverse_friendships, class_name: "Friendship", foreign_key: "friend_id"
  has_many :inverse_friends, through: :inverse_friendships, source: :user
  has_many :collaborations
  has_many :shared_wikis, through: :collaborations, source: :wiki, dependent: :destroy
  before_create :set_free_user
  mount_uploader :avatar, AvatarUploader

  ROLES = %w[free premium admin]
  def role?(base_role)
    role.nil? ? false : ROLES.index(base_role.to_s) <= ROLES.index(role)
  end

  def voted(section)
    self.votes.where(section_id: section.id).first
  end

  def vote_for(section)
    section.votes.where(user_id: self.id).first
  end

  def mutual_friends
    inverse_friends.joins(:friendships).where("friendships.user_id = users.id and friendships.friend_id = :self_id", :self_id => id).all
  end
  
  private

  def set_free_user
    self.role = 'free'
  end
end
