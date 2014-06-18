class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    alias_action :create, :update, :destroy, :new, :read, :to => :crud
    alias_action :update, :destroy, :to => :private_actions

    # public actions
    can :public_actions, UserType1
    can :create_from_twitter, UserType1
    can :create_from_facebook, UserType1
    can :create, UserType1
    can :create, UserType2
    can :new_type1, User
    can :new_type2, User
    can :index, :user_type1

    case user.type_type
    when "Admin"
      can :manage, :all
    when "UserType1"  
      can :manage, :protected_static_page
      can :manage, UserType1 do |u|
        u == user.type
      end
      can :manage, User do |u|
        u == user
      end
      
      can :add_twitter_uid, :user_type1       
      can :add_facebook_uid, :user_type1       
      can :destroy_twitter, :user_type1
      can :destroy_facebook, :user_type1

      can :read, [:thing1, :thing2, :thing3] 
      can :private_actions, [:thing1, :thing2, :thing3]
      can :crud, [:thing1, :thing2, :thing3]

    when "UserType2"
      can :manage, :protected_static_page
      can :manage, UserType2 do |u|
        u == user.type
      end

      can :read, [:thing1, :thing2, :thing3]
    end
  end
end
