class Post < ApplicationRecord
  belongs_to :user
  has_many :comments

  validates :content, presence: { message: "を入力してください" }
  validates :content, length: { maximum: 140, too_long: "は140文字以内で入力してください" }
end
