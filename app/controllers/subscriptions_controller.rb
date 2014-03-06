class SubscriptionsController < ApplicationController
  def new
    @subscription = Subscription.new
  end

  def create
    @subscription = Subscription.new(params[:subscription])
    if @subscription.save_with_payment
      current_user.update_attribute(:role, 'premium')
      @subscription.update_attribute(:user_id, current_user.id)
      flash[:notice] = "Thank you for upgrading!"
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    binding.pry
    @subscription = current_user.subscription.plan_id
  end

  def update
    @subscription = Stripe::Customer.retrieve(current_user.subscription.stripe_customer_token)
    if @subscription.cancel_subscription
      current_user.update_attribute(:role, 'free')
      current_user.subscription.destroy
      redirect_to root_path, :notice => "Thank you for trying Premium."
    else
      flash[:error] = "Sorry, cancelling the subscription has failed."
      render :edit
    end
  end
end
