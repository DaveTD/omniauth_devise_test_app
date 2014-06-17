class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    alias_action :create, :update, :destroy, :new, :show, :index, :to => :incuds
    alias_action :create, :new, :update, :destroy, :to => :private_actions
    alias_action :read, :show, :index, :to => :public_actions

    # public actions
    can :public_actions, UserType1
    can :create_from_twitter, UserType1
    can :create_from_facebook, UserType1
    can :create, UserType1
    can :create, UserType2
    can :new_type1, User
    can :new_type2, User

    case user.type_type
    when "Admin"
      can :manage, :all
    when "UserType1"  
      can :manage, :protected_static_page
      can :read, UserType1

      can :manage, UserType1 do |u|
        u == user.type
      end
      can :manage, User do |u|
        u == user
      end

      can :public_actions, [:thing1, :thing2, :thing3] 
      can :private_actions, [:thing1, :thing2, :thing3]

    when "UserType2"
      can :manage, UserType2
      can :manage, :protected_static_page

      can :public_actions, [:thing1, :thing2, :thing3]
    end
  end
end
