class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :section
  belongs_to :wiki

  attr_accessible :value, :section_id, :user_id, :wiki_id

  #after_save :display_vote

  #validates :value, inclusion: { in: [0, 10], message: "%{value} is not a valid vote." }

end
