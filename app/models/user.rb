class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:twitter]

  belongs_to :type, polymorphic: true, :dependent => :destroy

  def self.find_for_twitter_oauth(auth)
    user1 = UserType1.find_by( :twitter_uid => auth.uid )
    if user1
      user1.user
    end
  end


  def self.find_for_facebook_oauth(auth)
    user1 = UserType1.where( :facebook_uid => auth.uid ).user
    if user1
      user1.user
    end
  end

end
