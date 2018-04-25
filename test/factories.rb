FactoryBot.define do

  sequence :email do
    Faker::Internet.email
  end

  sequence :first_name do
    Faker::Name.first_name.downcase
  end

  sequence :last_name do
    Faker::Name.last_name.downcase
  end

  sequence :location do
    "#{Faker::Address.city}, #{Faker::Address.country}"
  end

  sequence :password do
    Faker::Internet.password(6, 50)
  end

  factory :user, aliases: [:friend] do
    association :profile, strategy: :build
    password
    email
  end

  factory :profile do
    first_name
    last_name
    location
  end

  factory :friendship do
    user
    friend
  end

  factory :friend_request do
    user
    friend
  end

end
