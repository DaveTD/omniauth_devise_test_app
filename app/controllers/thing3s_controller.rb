class Thing3sController < ApplicationController
  include Protector

  def new
    @thing = Thing3.new
  end

  def create
    if current_user.type.thing.nil?
      @thing = Thing3.new(thing3_params)
      if @thing.save
        current_user.type.update_attributes(:thing => @thing)
        flash[:success] = "Thing added"
      end
    end
    redirect_to user_home_path
  end

  def show
    @thing = Thing3.find(params[:id])
  end

  def index
    @things = Thing3.all
  end

  def update
  end

  def destroy
    # check if admin, set user by param if true
    if current_user.type == "Admin"
      @thing = Thing3.find(params[:id])
      @thing.destroy!
      @user = UserType1.find_by_things_id(params[:id])
      @user.update_attributes(:thing => nil)
      redirect_to user_home_path
    end
    # check current user to get id
    redirect_to user_home_path
  end
  
  private
    def thing3_params
      params.require(:thing3).permit(
        :id, :thing_id, :thing_type, :thing_name, :thing_description
      )
    end

end
