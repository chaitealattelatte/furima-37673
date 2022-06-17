FactoryBot.define do
  factory :item do
    name            { Faker::Verb.base }
    description     { Faker::Lorem.sentence }
    category_id     { Faker::Number.within(range: 2..11) }
    condition_id    { Faker::Number.within(range: 2..7) }
    charge_id       { Faker::Number.within(range: 2..3) }
    source_id       { Faker::Number.within(range: 2..48) }
    delivery_day_id { Faker::Number.within(range: 2..4) }
    price           { Faker::Number.within(range: 300..9_999_999) }
    association :user
    after(:build) do |item|
      item.image.attach(io: File.open('public/images/a.png'), filename: 'a.png')
    end
  end
end
