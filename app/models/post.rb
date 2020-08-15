class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  scope :desc,      -> {order('created_at DESC')}
  scope :including, -> {includes(:user)}

validates :text, {length: { maximum: 140 }, presence: true}
end
