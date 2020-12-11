FactoryBot.define do
  factory :user do
    name { "テストユーザ" }
    email { "abc@abc.com" }
    password { "abcd1234" }
    password_confirmation { password }
  end
end
