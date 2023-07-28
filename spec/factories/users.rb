FactoryBot.define do
  factory :user do
    nickname {Faker::Name.last_name} 
    email {Faker::Internet.email} 
    password {'1a' + Faker::Internet.password(min_length: 6)} 
    password_confirmation {password} 
    family_name {Gimei.name.family.kanji}
    first_name {Gimei.name.first.kanji}
    family_name_kana {Gimei.name.family.katakana}
    first_name_kana {Gimei.name.first.katakana}
    birthday {Faker::Date.birthday}
  end
end
