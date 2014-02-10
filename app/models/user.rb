class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :role, :last_4_digits
  has_one :subscription, dependent: :destroy
  has_many :posts
  before_create :set_free_user
  #after_create :create_stripe_member

  ROLES = %w[free premium admin]
  def role?(base_role)
    role.nil? ? false : ROLES.index(base_role.to_s) <= ROLES.index(role)
  end

  def plan_name
    self.subscription.plan.name
  end

  def has_plan?
    !self.subscription.nil?
  end

  def premium_user?
    self.plan_name == "premium"
  end

  private

  def set_free_user
    self.role = 'free'
  end
end
