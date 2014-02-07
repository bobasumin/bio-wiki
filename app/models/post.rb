class Post < ActiveRecord::Base
  attr_accessible :body, :title, :public
  belongs_to :user

  default_scope order('created_at DESC')

  validates :title, length: { minimum: 2 }, presence: true
  validates :body, length: { minimum: 5 }, presence: true
  validates :user, presence: true

  def public?
    return self if self.public == true
  end

  def private?
    return self if self.public == false
  end
end
