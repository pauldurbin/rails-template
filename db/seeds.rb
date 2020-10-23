# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

site = Site.create(name: production_hostname)

%w(deity admin user).each do |role|
  Role.create(name: role, site: site)
end

User.new(email: 'hello@pauldurbin.co.uk', password: 'Password1!', password_confirmation: 'Password1!').tap do |user|
  user.roles << Role.find_by_name('deity')
  user.save
end

User.new(email: 'admin@thedoor.ws', password: 'Password1!', password_confirmation: 'Password1!').tap do |user|
  user.roles << Role.find_by_name('deity')
  user.save
end
