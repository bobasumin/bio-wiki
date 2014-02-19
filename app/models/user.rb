class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :role, :stripe_customer_token, :shared_wikis, :birthdate, :avatar
  has_one :subscription, dependent: :destroy
  has_one :wiki
  has_many :collaborations
  has_many :shared_wikis, through: :collaborations, source: :wiki, dependent: :destroy
  before_create :set_free_user
  mount_uploader :avatar, AvatarUploader

  ROLES = %w[free premium admin]
  def role?(base_role)
    role.nil? ? false : ROLES.index(base_role.to_s) <= ROLES.index(role)
  end

  private

  def set_free_user
    self.role = 'free'
  end
end
