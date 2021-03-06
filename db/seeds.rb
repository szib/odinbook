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

start_time = Time.now
puts " Seeding starts at #{start_time} ".center(79,'#')

# USERS
add_user(
  email: "miyamoto@manga-world.jp",
  password: 'foobar',
  first_name: 'Miyamoto',
  last_name: 'Usagi',
  location: 'Japan'
)

add_user(
  email: "tomoe@manga-world.jp",
  password: 'foobar',
  first_name: 'Ame',
  last_name: 'Tomoe',
  location: 'Japan'
)

add_user(
  email: "gennosuke@manga-world.jp",
  password: 'foobar',
  first_name: 'Gennosuke',
  last_name: 'Murakami',
  location: 'Japan'
)

12.times do
  add_user(
    email: Faker::Internet.email,
    password: 'foobar',
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    location: "#{Faker::Address.city}, #{Faker::Address.country}"
  )
end

# USER RELATIONS
Friendship.create(user: User.first, friend: User.find(2))
Friendship.create(user: User.first, friend: User.find(3))
FriendRequest.create(user: User.second, friend: User.third)
FriendRequest.create(user: User.find(5), friend: User.first)
FriendRequest.create(user: User.find(6), friend: User.first)
FriendRequest.create(user: User.find(7), friend: User.first)
FriendRequest.create(user: User.first, friend: User.find(8))

# POSTS
(1..12).each do |n|
  faked_content = Faker::Lorem.paragraph(10)
  Post.create(author: User.find(n), content: faked_content)
end

# POST LIKES
Like.create(likeable: Post.first, user: User.first)
Like.create(likeable: Post.first, user: User.second)
Like.create(likeable: Post.first, user: User.third)

# COMMENTS
Comment.create(post: Post.first, author: User.second, content: Faker::Lorem.paragraph(4))
Comment.create(post: Post.first, author: User.third, content: Faker::Lorem.paragraph(4))
Comment.create(post: Post.second, author: User.second, content: Faker::Lorem.paragraph(4))

# COMMENT LIKES
Like.create(likeable: Comment.first, user: User.first)
Like.create(likeable: Comment.second, user: User.first)
Like.create(likeable: Comment.first, user: User.third)

finish_time = Time.now
duration = Time.at(finish_time-start_time).utc.strftime("%M:%S.%L")
puts " Seeding ends at #{finish_time} ".center(79,'#')
puts " Duration: #{duration} ".center(79,'#')
