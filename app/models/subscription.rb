class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :plan

  attr_accessible :plan_id, :email, :user
  delegate :stripe_plan_id, to: :plan
end
