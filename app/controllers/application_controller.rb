class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    if current_user.nil?
      redirect_to root_path, :alert => exception.message
    else
      redirect_to user_home_path, :alert => exception.message
    end
  end

  def after_sign_in_path_for(user)
    user_home_path
  end
  def after_sign_out_path_for(user)
    root_path
  end
  def after_sign_up_path_for(user)
    user_home_path
  end


end
