class UserType1sController < ApplicationController
  include Protector
  skip_before_filter :authenticate_user!, :only => [:create, :create_from_twitter, :new, :read]
  

  def new
    @user_type1
  end

  def create_from_twitter
    @user = User.new
    @user_type1 = UserType1.new
    @auth = session["devise.twitter_data"]
  end

  def create_from_facebook

  end

  def create 
    @user_type1 = UserType1.new(user_type1_params)
    
    @user = @user_type1.build_user(:email => params["user_type1"]["users"]["email"], :password => params["user_type1"]["users"]["encrypted_password"])

    if @user.valid? && @user_type1.valid?
      p ">>> Saving User..."
      @user_type1.save 
      sign_in @user
      p ">>> Redirecting..."
      redirect_to user_home_path
    else
      @user_type1.errors.full_messages.each do |m|
        # Log this better.
        p m
      end
    end
  end
  
  def read
    @user_type1 = UserType1.find(params[:id])
  end

  def update
    @user_type1 = UserType1.find(params[:id])
    @user_type1.update!(user_params)
    redirect_to user_home_path
  end

  def destroy_thing
    if current_user.type == "Admin"
      @target = @user_type1.find(params[:id])
      @target.thing.destroy
      @target.update_attributes(:thing => nil)
      redirect_to user_home_path
    end    
    current_user.type.thing.destroy
    current_user.type.update_attributes(:thing => nil)
    redirect_to user_home_path
  end

  private
    def user_type1_params
      #params.require(:user_type1).permit( 
      #  :name, 
      #  :location, 
      #  :twitter_uid, 
      #  :facebook_uid, 
      #  users_attributes: [:id, :email, :password, :type_id, :type_type]
      #)
      params.permit( 
        :name, 
        :location, 
        :twitter_uid, 
        :facebook_uid, 
        :thing_id,
        :thing_type,
        users_attributes: [:id, :email, :password, :type_id, :type_type],
        thing1_attributes: [:id, :thing_name, :thing_description, :thing_stat, :thing_other_stat, :thing_occurrance_date]
      )
    end

end
