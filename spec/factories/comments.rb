FactoryBot.define do
  factory :comment do
    comment { "コメント内容" }
    association :user
    association :post
  end
end
