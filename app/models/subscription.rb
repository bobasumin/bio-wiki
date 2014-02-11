class Subscription < ActiveRecord::Base
  attr_accessor :stripe_card_token
  belongs_to :user
  belongs_to :plan
  validates_presence_of :plan_id
  validates_presence_of :email  

  attr_accessible :email, :plan_id, :stripe_customer_token, :user_id, :stripe_card_token

  def save_with_payment
    if valid?
      customer = Stripe::Customer.create(email: email, plan: 'premium', card: stripe_card_token)
      self.stripe_customer_token = customer.id
      save!
    end
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while creating customer: #{e.message}"
    errors.add :base, "There was a problem with your credit card."
    false
  end
end
