class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    alias_action :create, :read, :update, :destroy, :new, :show, :index, :to => :incruds
    alias_action :create, :new, :update, :destroy, :to => :private_actions
    alias_action :read, :show, :index, :to => :public_actions

    # public actions
    can :public_actions, :user_type1
    can :create_from_twitter, :user_type1
    can :create_from_facebook, :user_type1
    can :create, :user_type1
    can :create, :user_type2
    can :new_type1, :user
    can :new_type2, :user

    case user.type_type
    when "admin"
      can :manage, :all
    when "UserType1"  
      can :manage, :user_type1
      can :manage, :protected_static_page
       
      can :public_actions, [:thing1, :thing2, :thing3] 
      can :private_actions, [:thing1, :thing2, :thing3] # Set user ID

    when "UserType2"
      can :manage, :user_type2
      can :manage, :protected_static_page

      can :public_actions, [:thing1, :thing2, :thing3]
    end
  end
end
