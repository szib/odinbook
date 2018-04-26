FactoryBot.define do
  sequence :first_name do
    Faker::Name.first_name.downcase
  end

  sequence :last_name do
    Faker::Name.last_name.downcase
  end

  sequence :location do
    "#{Faker::Address.city}, #{Faker::Address.country}"
  end

  factory :profile do
    first_name
    last_name
    location
  end

end
