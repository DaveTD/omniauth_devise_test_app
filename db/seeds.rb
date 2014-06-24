# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if Admin.all.empty?
  # In the event that we have no admin, add one
  admin = Admin.new()
  adminuser = admin.build_user(:email => "admin@fake.com", :password => "fakeadmin")
  admin.save
end
