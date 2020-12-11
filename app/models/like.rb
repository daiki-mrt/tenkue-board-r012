class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  def self.exist_or_not?(like)
    user_id = like.user_id
    post_id = like.post_id

    Like.exists?(user_id: user_id, post_id: post_id) ? true : false
  end
end
