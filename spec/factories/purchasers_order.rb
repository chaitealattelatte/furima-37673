FactoryBot.define do
  factory :purchasers_order do
    post_code     { Faker::Number.number(digits: 7).to_s.insert(3, '-') }
    source_id     { Faker::Number.within(range: 2..48) }
    city          { Gimei.address.city.kanji }
    address       { Faker::Number.number(digits: 3).to_s.insert(1, '-') }
    building      { Faker::Lorem.word }
    phone         { Faker::Number.number(digits: 10) }
    token         { Faker::Number.number(digits: 32) }
  end
end
