FactoryBot.define do
  factory :order_address do
    postal_code {"#{Faker::Number.between(from: 100, to: 999)}-#{Faker::Number.between(from: 1000, to: 9999)}"} 
    prefecture_id { Faker::Number.within(range: 2..48) }
    city {Faker::Address.city} 
    street_address {Faker::Address.street_name}
    building_name {Faker::Games::Touhou}
    phone_number {Faker::Number.number(digits: 10)}
  end
end
