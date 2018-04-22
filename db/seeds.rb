# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
def add_user(params)
  user = User.new(email:                  params[:email],
                  password:               params[:password],
                  password_confirmation:  params[:password])
  user.build_profile(first_name: params[:first_name],
                     last_name:  params[:last_name],
                     location:   params[:location])
  user.save
  puts "id: #{user.id}\t\temail: #{user.email}"
end


puts " Seeding starts at #{Time.now} ".center(79,'#')

add_user(
  email: "usagi@yojimbo.jp",
  password: 'foobar',
  first_name: 'Usagi',
  last_name: 'Yojimbo',
  location: 'Japan'
)

10.times do
  add_user(
    email: Faker::Internet.email,
    password: 'foobar',
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    location: "#{Faker::Address.city}, #{Faker::Address.country}"
  )
end

puts " Seeding ends at #{Time.now} ".center(79,'#')
