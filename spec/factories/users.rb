FactoryBot.define do
  factory :user do
    transient do
      person { Gimei.name }
    end
    nickname              { Faker::Name.initials(number: 2) }
    email                 { Faker::Internet.free_email }
    password              { Faker::Lorem.characters(number: 6, min_alpha: 1, min_numeric: 1) }
    password_confirmation { password }
    family_name           { person.first.kanji }
    first_name            { person.last.kanji }
    kana_family           { person.first.katakana }
    kana_first            { person.last.katakana }
    date_of_birth         { Faker::Date.backward }
  end
end
