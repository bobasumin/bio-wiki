class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :section

  attr_accessible :value, :section_id, :user_id

  #validates :value, inclusion: { in: [0, 10], message: "%{value} is not a valid vote." }
  
  #after_save :update_wiki

end
