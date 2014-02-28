class Biocard < ActiveRecord::Base
  attr_accessible :dob, :pob, :nationality, :location
  belongs_to :wiki
end
