class Wiki < ActiveRecord::Base
  attr_accessible :user_ids, :sections_attributes, :user_id
  belongs_to :user
  has_many :sections
  accepts_nested_attributes_for :sections, allow_destroy: true

  has_many :collaborations
  has_many :users, through: :collaborations

  default_scope order('created_at DESC')

  validates :user, presence: true
end
