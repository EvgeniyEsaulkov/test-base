FactoryBot.define do
  factory :todo do
    title { Faker::Book.title }
  end
end
