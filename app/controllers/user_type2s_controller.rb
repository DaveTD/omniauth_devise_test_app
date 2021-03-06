class UserType2sController < ApplicationController
  load_resource
  include Protector
  skip_before_filter :authenticate_user!, :only => [:create, :new, :read]

  def new
    @user_type2
  end

  def create
    @user_type2 = UserType2.new(user_type2_params)

    @user = @user_type2.build_user(:email => params["user_type2"]["users"]["email"], :password => params["user_type2"]["users"]["encrypted_password"])

    if @user.valid? && @user_type2.valid?
      p ">>> Saving User..."
      @user_type2.save 
      sign_in @user
      p ">>> Redirecting..."
      redirect_to user_home_path
    else
      @user_type2.errors.full_messages.each do |m|
        p m
      end
    end

  end

  def show
    @usertype2 = UserType2.find(params[:id])
  end

  def edit
    @usertype2 = UserType2.find(params[:id])
  end

  def update
    @usertype2 = UserType2.find(params[:id])
    @usertype2.update!(user_type2_params)
    redirect_to user_home_path
  end

  private
    def user_type2_params
      params.require(:user_type2).permit( :location, users_attributes: [:id, :email, :password, :type_id, :type_type])
    end

end

