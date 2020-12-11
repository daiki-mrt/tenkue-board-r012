FactoryBot.define do
  factory :user do
    name { "テストユーザ" }
    sequence(:email) { |n| "abc#{n}@abc.com" }
    password { "abcd1234" }
    password_confirmation { password }
  end
end
