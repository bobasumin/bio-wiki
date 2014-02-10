class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.role? :free
        can :manage, Post, :user_id => user.id
        can :manage, Subscription, :user_id => user.id
    end

    if user.role? :premium
        can :manage, Post, public: false
    end

    if user.role? :admin
        can :manage, :all
    end

    can :read, Post, public: true
  end
end
