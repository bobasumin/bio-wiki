class Post < ActiveRecord::Base
  attr_accessible :public, :summary, :earlylife, :career, :personallife, :birthdate, :user_ids
  belongs_to :user
  has_many :collaborations
  has_many :users, through: :collaborations

  default_scope order('created_at DESC')

  validates :summary, length: { minimum: 5 }, presence: true
  validates :user, presence: true

  extend FriendlyId
  friendly_id :user, use: [:slugged, :history]

  FriendlyId.defaults do |config|
    config.use :reserved
    config.reserved_words = %w(new edit)
  end
end
