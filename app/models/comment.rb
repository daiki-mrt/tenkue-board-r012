class Comment < ApplicationRecord
  belongs_to :user  
  belongs_to :post
  validates :text, presence: true

  scope :desc,      -> {order('created_at DESC')}
  scope :including, -> {includes(:user)}
end
