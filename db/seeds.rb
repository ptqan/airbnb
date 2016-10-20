# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

city = City.create([{name: 'Kuala Lumpur', state: "Kuala Lumpur", country: "Malaysia"}, {name: 'Ipoh', state: 'Perak', country: 'Malaysia'}])

User.create([{name: "Brigitte", email: "abc@gmail.com", password: "12341234"}, {name: "John Doe", email: "j@doe.com", password: "12341234"}])