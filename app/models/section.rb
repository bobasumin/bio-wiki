class Section < ActiveRecord::Base
  attr_accessible :name, :body, :votes_attributes, :wiki_id
  belongs_to :wiki
  has_many :votes, dependent: :destroy
  accepts_nested_attributes_for :votes, :allow_destroy => true

  #validates :summary, length: { minimum: 5 }, presence: true
end
