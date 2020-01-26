FactoryBot.define do
  factory :todo do
    executor
    content { Faker::Lorem.paragraph }
  end
end
