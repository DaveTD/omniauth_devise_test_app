class ProtectedStaticPagesController < ApplicationController
  include Protector

  def home
    # authorize! :read, :ProtectedStaticPage
    @user_signed_in = user_signed_in?
    @user_session = user_session
    @currentuser = current_user
  end

end
