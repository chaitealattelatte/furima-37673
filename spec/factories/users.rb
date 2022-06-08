FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.initials(number: 2) }
    email                 { Faker::Internet.free_email }
    password              { Faker::Lorem.characters(number: 6, min_alpha: 1, min_numeric: 1) }
    password_confirmation { password }
    family_name           { Faker::Name.initials(number: 2) }
    first_name            { Faker::Name.initials(number: 2) }
    kana_family           { Faker::Name.initials(number: 2) }
    kana_first            { Faker::Name.initials(number: 2) }
    date_of_birth         { Faker::Date.backward }
  end
end
