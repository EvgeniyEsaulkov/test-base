FactoryBot.define do
  factory :carwash do
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
  end
end
