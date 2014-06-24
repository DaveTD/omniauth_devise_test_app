class Thing1 < ActiveRecord::Base
  has_one :user_type1s, as: :thing



  before_destroy do |record|
    # I can't see this performing well, this is probably way slower than it can be.
    UserType1.find_by_thing_id_and_thing_type(record.id, record.class.name).update_attributes(:thing => nil)
  end
end
