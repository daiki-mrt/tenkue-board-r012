class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :content, presence: { message: "を入力してください" }
  validates :content, length: { maximum: 140, too_long: "は140文字以内で入力してください" }
end
