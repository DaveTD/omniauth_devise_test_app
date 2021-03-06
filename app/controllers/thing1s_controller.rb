class Thing1sController < ApplicationController
  load_resource
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
  
  def show
  end

  def index
    @things = Thing1.all
  end

  def update
    @thing1.update!(thing1_params)
    redirect_to thing1_path
  end

  def destroy
    @thing1.destroy!
    redirect_to user_home_path
  end

  private
    def thing1_params
      params.require(:thing1).permit(
        :id, :thing_id, :thing_type, :thing_name, :thing_description, :thing_stat, :thing_other_stat, :thing_occurrance_date
      )
    end

end
