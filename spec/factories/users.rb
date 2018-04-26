FactoryBot.define do
  sequence :email do
    Faker::Internet.email
  end

  sequence :password do
    Faker::Internet.password(6, 50)
  end

  factory :user, aliases: [:friend] do
    association :profile, strategy: :build
    password
    email
  end

end
