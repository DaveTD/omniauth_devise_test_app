class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    alias_action :create, :update, :destroy, :new, :read, :to => :crud
    alias_action :show, :update, :destroy, :to => :private_actions

    # public actions
    can :read, UserType1
    can :create_from_twitter, :user_type1
    can :create_from_facebook, :user_type1
    can :new_type1, :user
    can :new_type2, :user
    can :create, UserType1
    can :create, UserType2
    can :new_type1, User
    can :new_type2, User
    can :index, :user_type1
    can :manage, User do |u|
      user == u
    end

    case user.type_type
    when "Admin"
      can :manage, :all
    when "UserType1"  
      can :manage, :protected_static_page
      can :manage, UserType1 do |u|
        user.type == u
      end
      
      can :add_twitter_uid, :user_type1       
      can :add_facebook_uid, :user_type1       
      can :destroy_twitter, :user_type1
      can :destroy_facebook, :user_type1
      can :destroy_thing, :user_type1

      can :index, [:thing1, :thing2, :thing3] 
      can :create, [Thing1, Thing2, Thing3]
      can :private_actions, [Thing1, Thing2, Thing3] do |t|
        user.type.thing == t        
      end

    when "UserType2"
      can :manage, :protected_static_page
      can :manage, UserType2 do |u|
        user.type == u
      end

      can :read, [:thing1, :thing2, :thing3]
    end
  end
end
