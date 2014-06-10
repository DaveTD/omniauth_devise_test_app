class UserType1 < ActiveRecord::Base
  has_one :user, as: :type
  belongs_to :thing, polymorphic: true
  accepts_nested_attributes_for :user

end
