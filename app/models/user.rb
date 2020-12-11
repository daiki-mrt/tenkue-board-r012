class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  validates :name, presence: true
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: EMAIL_REGEX }
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])\w{8,32}\z/
  validates :password, presence: true, format: { with: PASSWORD_REGEX }

  def self.guest
    user = User.find_or_create_by!(email: 'guest@example.com', name: 'ゲストユーザ') do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end
end
