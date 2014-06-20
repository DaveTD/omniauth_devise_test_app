class Thing2sController < ApplicationController
  load_resource
  include Protector

  def new
    @thing = Thing2.new
  end

  def create
    if current_user.type.thing.nil?
      @thing = Thing2.new(thing2_params)
      if @thing.save
        current_user.type.update_attributes(:thing => @thing)
        flash[:success] = "Thing added"
      end
    end
    redirect_to user_home_path
  end

  def show
  end

  def index
    @things = Thing2.all
  end

  def update
    @thing2.update!(thing2_params)
    redirect_to thing2_path
  end

  def destroy
    # check if admin, set user by param if true
    if current_user.type == "Admin"
      @thing = Thing2.find(params[:id])
      @thing.destroy!
      @user = UserType1.find_by_thing_id_and_thing_type(params[:id], "Thing2")
      @user.update_attributes(:thing => nil)
      redirect_to user_home_path
    end
    # check current user to get id
    redirect_to user_home_path
  end

  private
    def thing2_params
      params.require(:thing2).permit(
        :id, :thing_id, :thing_type, :thing_name, :thing_description, :thing_equipment, :thing_stat
      )
    end

end
