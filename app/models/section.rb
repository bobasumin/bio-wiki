class Section < ActiveRecord::Base
  attr_accessible :name, :body, :summary, :birthdate
  belongs_to :wiki

  #validates :summary, length: { minimum: 5 }, presence: true
end
