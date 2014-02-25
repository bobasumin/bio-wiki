class Section < ActiveRecord::Base
  attr_accessible :name, :body
  belongs_to :wiki

  #validates :summary, length: { minimum: 5 }, presence: true
end
