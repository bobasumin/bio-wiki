class Biocard < ActiveRecord::Base
  attr_accessible :dob, :pob, :nationality
  belongs_to :wiki
end
