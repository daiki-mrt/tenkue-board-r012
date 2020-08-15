class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :name, presence: true
  validates :password, {length: { in: 8..32 }, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]/}}
  before_save { self.email = email.downcase }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, {presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }}

  def already_liked?(post)
    self.likes.exists?(post_id: post.id)
  end

end
