class Post < ActiveRecord::Base
  attr_accessible :body, :title, :public
  belongs_to :user
  has_many :collaborations
  has_many :users, through: :collaborations

  default_scope order('created_at DESC')

  validates :title, length: { minimum: 2 }, presence: true
  validates :body, length: { minimum: 5 }, presence: true
  validates :user, presence: true
end
