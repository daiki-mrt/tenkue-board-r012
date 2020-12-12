FactoryBot.define do
  factory :post do
    content { "投稿内容" }
    association :user
  end
end
