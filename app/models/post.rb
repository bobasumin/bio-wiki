class Post < ActiveRecord::Base
  attr_accessible :body, :title, :public, :user_ids, :image
  belongs_to :user
  has_many :collaborations
  has_many :users, through: :collaborations

  mount_uploader :image, ImageUploader

  default_scope order('created_at DESC')

  validates :title, length: { minimum: 2 }, presence: true
  validates :body, length: { minimum: 5 }, presence: true
  validates :user, presence: true

  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]

  FriendlyId.defaults do |config|
    config.use :reserved
    config.reserved_words = %w(new edit)
  end
end
