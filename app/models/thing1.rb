class Thing1 < ActiveRecord::Base
  has_one :user_type1s, as: :thing
end
