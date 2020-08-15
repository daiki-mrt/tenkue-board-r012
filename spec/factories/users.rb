FactoryBot.define do
  factory :user do
    email                 { Faker::Internet.email }
    password              { "abcd1234" }
    password_confirmation { "abcd1234" }
    name                  { Faker::Name.name }
  end
end