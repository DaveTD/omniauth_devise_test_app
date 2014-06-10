class UserType2 < ActiveRecord::Base
  has_one :user, as: :type
  accepts_nested_attributes_for :user
end
