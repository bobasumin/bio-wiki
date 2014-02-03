class Post < ActiveRecord::Base
  attr_accessible :body, :title, :type
  belongs_to :user
  belongs_to :type

  default_scope order('created_at DESC')
end
