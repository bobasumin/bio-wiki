class SubscriptionsController < ApplicationController
  def new
    @plans = Plan.all
    @subscription = Subscription.new
    authorize! :create, Subscription, message: "You need to be a member to upgrade to premium."
  end

  def create
   @subscription = current_user.build_subscription(params[:subscription])
    token = params[:stripeToken]
    authorize! :create, Subscription, message: "You need to be a member to do that."
      begin
        customer = Stripe::Customer.retrieve(current_user.stripe_id)
        customer.update_subscription(plan: @subscription.stripe_plan_id, card: token)
        if @subscription.save
          redirect_to root_path, notice: "Subscription updated successfully."
        else
          redirect_to root_path, error: "there was a problem saving your subscription"
        end
      rescue Stripe::StripeError => e
        redirect_to new_subscription_path, notice: e.message
      end
  end

  def show
    @subscription = current_user.subscription
    @plans = Plan.all
    authorize! :read, Subscription, message: "You need to be a member to do that."
  end

  def edit
    @subscription = current_user.subscription
    @plans = Plan.all
    authorize! :edit, Subscription, message: "You need to be a member to do that."
  end

  def update
    @new_plan_id = params[:subscription][:plan_id] #just keeping the plan ID
    @current_subscription = current_user.subscription
    token = params[:stripeToken]
    authorize! :update, Subscription, message: "You need to  be a member to do that."

    begin
      customer = Stripe::Customer.retrieve(current_user.stripe_id)
      customer.update_subscription(plan: @new_plan_id, card: token)
      if @current_subscription.update_attribute(:plan_id, @new_plan_id)
        redirect_to root_path, notice: "Subscription successfully updated"
      else
        flash[:notice] = "There was an error saving your subscription changes"
        render :edit
      end
    rescue Stripe::StripeError => e
      redirect_to edit_subscription_path, notice: e.message
    end
  end
end
