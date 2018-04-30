FactoryBot.define do
  sequence :content do
    Faker::Lorem.paragraph(10)
  end

  factory :post do
    author
    content
  end

end
