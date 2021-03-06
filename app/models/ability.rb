class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.role? :free
        can :create, Wiki
        can :manage, Wiki, :user_id => user.id
        can :manage, Subscription, :user_id => user.id
    end

    if user.role? :premium
        can :update, user.shared_wikis
        can :create, Vote
        can :update, Vote
    end

    if user.role? :admin
        can :manage, :all
    end

    can :read, Wiki
  end
end
