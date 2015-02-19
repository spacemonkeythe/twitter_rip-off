# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

10.times do |n|
  name  = "example-#{n+1}"
  email = "example-#{n+1}@example.com"
  password = "passwordpassword"
  User.create!(name:  name,
               email: email,
               password: password,
               password_confirmation: password)
end
