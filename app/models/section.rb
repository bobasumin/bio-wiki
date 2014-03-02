class Section < ActiveRecord::Base
  attr_accessible :name, :body
  belongs_to :wiki
  has_many :votes, dependent: :destroy

  #validates :summary, length: { minimum: 5 }, presence: true
end
