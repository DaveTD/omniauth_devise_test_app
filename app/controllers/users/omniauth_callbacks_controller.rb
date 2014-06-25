class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  before_filter :authenticate_user!

  def twitter
    # raise request.env["omniauth.auth"].to_yaml 
    @user = User.find_for_twitter_oauth(request.env["omniauth.auth"]) 
    if @user && @user.persisted?
      sign_in_and_redirect @user
    else
      session["devise.twitter_data"] = env["omniauth.auth"]["info"].to_hash.merge( "uid" => env["omniauth.auth"].uid )
      # If there is a user currently signed in with no twitter account associated with it, we must be adding this twitter to that account
      if (current_user && current_user.type.twitter_uid.nil?) 
        redirect_to '/add_twitter_uid' 
      else
        # Otherwise, create a new account from the twitter account
        redirect_to '/create_from_twitter'
      end
    end
  end

  def facebook
    # raise request.env["omniauth.auth"].to_yaml 
    @user = User.find_for_facebook_oauth(request.env["omniauth.auth"])

    if @user && @user.persisted?
      sign_in_and_redirect @user
    else
      session["devise.facebook_data"] = env["omniauth.auth"]["info"].to_hash.merge( "uid" => env["omniauth.auth"].uid, :email => env["omniauth.auth"].email )

      if (current_user && current_user.type.facebook_uid.nil?)
        redirect_to '/add_facebook_uid'
      else
        redirect_to create_from_facebook_path
      end
    end
  end

end
