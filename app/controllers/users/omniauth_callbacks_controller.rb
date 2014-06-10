class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def twitter
    # raise request.env["omniauth.auth"].to_yaml 
    @user = User.find_for_twitter_oauth(request.env["omniauth.auth"]) 
    if @user && @user.persisted?
      p ">>> signing in: #{ @user.email }"
      sign_in_and_redirect @user
      # redirect_to root_path
    else
      session["devise.twitter_data"] = env["omniauth.auth"]["info"].to_hash.merge( "uid" => env["omniauth.auth"].uid )
      redirect_to '/create_from_twitter'
    end

  end

  def facebook
    @user = User.find_for_facebook_oauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication
    else
      session["devise.facebook_data"] = env["omniauth.auth"]["info"].to_hash.merge( :uid => env["omniauth.auth"].uid )
      redirect_to create_from_facebook_path
    end
  end

end
