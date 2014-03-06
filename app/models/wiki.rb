class Wiki < ActiveRecord::Base
  searchkick
  attr_accessible :user_ids, :sections_attributes, :biocard_attributes, :title
  belongs_to :user
  has_many :sections
  has_many :votes
  has_one :biocard
  accepts_nested_attributes_for :sections, :reject_if => lambda { |a| a[:name].blank? }, allow_destroy: true
  accepts_nested_attributes_for :biocard

  has_many :collaborations
  has_many :users, through: :collaborations
  before_save :set_title

  default_scope order('created_at DESC')

  validates :user, presence: true

  def set_title
    self.title = self.user.name
  end
end
