class Comment < ApplicationRecord
  belongs_to :user  
  belongs_to :post
  validates :text, {length: { maximum: 140 }, presence: true}

  scope :desc,      -> {order('created_at DESC')}
  scope :including, -> {includes(:user)}
end
