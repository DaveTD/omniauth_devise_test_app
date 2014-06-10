class Thing1sController < ApplicationController
  include Protector

  def new
    @thing = Thing1.new
  end

  def create
    if current_user.type.thing.nil?
      @thing = Thing1.new(thing1_params)
      if @thing.save
        current_user.type.update_attributes(:thing => @thing)
        flash[:success] = "Thing added"
      end
    end
    redirect_to user_home_path
  end
  
  def read
    # Check userid from params
  end

  def update
    # check if admin, set user by param if true
    # if not,
    # check current user
  end

  def destroy
    # check if admin, set user by param if true
    if current_user.type == "Admin"
      @thing = Thing1.find(params[:id])
      @thing.destroy!
      @user = UserType1.find_by_things_id(params[:id])
      @user.update_attributes(:thing => nil)
      redirect_to user_home_path
    end
    # check current user to get id
    redirect_to user_home_path
  end

  private
    def thing1_params
      params.require(:thing1).permit(
        :id, :thing_id, :thing_type, :thing_name, :thing_description, :thing_stat, :thing_other_stat, :thing_occurrance_date
      )
    end

end
