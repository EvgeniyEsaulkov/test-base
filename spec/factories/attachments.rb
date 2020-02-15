FactoryBot.define do
  factory :attachment do
    attachment_size { Faker::Number.number(9) }
  end
end
