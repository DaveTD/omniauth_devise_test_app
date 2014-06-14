class Ability
  include CanCan::Ability

  def initialize(user)
    user_passed ||= User.new # guest user (not logged in)

    alias_action :create, :update, :destroy, :new, :show, :index, :to => :incuds
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

      can :manage, User do |u|
        u == user
      end

    when "UserType2"
      can :manage, :user_type2
      can :manage, :protected_static_page

      can :public_actions, [:thing1, :thing2, :thing3]
    end
  end
end
