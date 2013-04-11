class Ability
  include CanCan::Ability

  def initialize(user)
    # Instantiate guest user if necessary
    user ||= User.new

    # Define abilities
    if user.is?(:admin)
      can :manage, :all
    else
      can :read, :all
    end
  end
end

