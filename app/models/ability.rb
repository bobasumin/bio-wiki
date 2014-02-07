class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.role? :free
        can :manage, Post, :user_id => user.id
        can :read, Type, public: true
    end

    if user.role? :premium
        can :read, Type, public: false
    end

    if user.role? :admin
        can :manage, :all
    end
  end
end
