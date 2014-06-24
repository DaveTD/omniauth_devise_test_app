class UsersController < ApplicationController
  load_resource
  include Protector
  skip_before_filter :authenticate_user!, :only => [:new_type1, :new_type2]

  def new_type1
    @user = User.new
    @user_type1 = UserType1.new
  end

  def new_type2
    @user = User.new
    @user_type2 = UserType2.new
  end

  def show
    #@user = User.find(params[:id])
  end

  def index
    @users = User.all
  end

  def edit
    
  end

  def update
    @user = User.find(params[:id])
    @user.update!(user_params)
    redirect_to user_home_path
  end

  def destroy
    #@user = User.find(params[:id])
    @user.destroy!
    redirect_to user_home_path
  end

  private
    def user_params
      params.require(:user).permit(:id, :email, :password, :password_confirmation, :type_id, :type_type )
    end

end

