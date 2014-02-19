# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Plan.create!(name: "free", price: 0.00, description: ["Unlimited Wikis, Free!"].join("\n\n"))
Plan.create!(name: "premium", price: 4.99, description: ["Unlimited Private Wikis", "Unlimited Collaborators"].join("\n\n"))

admin = User.new(
  :name => "Soomin Kim",
  :email => "soomin@vuid.co",
  :password => "helloworld",
  :password_confirmation => "helloworld")
admin.skip_confirmation!
admin.save
admin.update_attribute(:role, "admin")