FactoryBot.define do

  factory :item do
    name { Faker::Lorem.characters(number: 10) }
    introduction { Faker::Lorem.characters(number: 50) }
    association :user
    association :genre
  end

end