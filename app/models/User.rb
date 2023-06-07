class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  has_many :articles, dependent: :destroy
  validates :username, presence: true, uniqueness: true, length:{minimum:3, maximum:50}
  validates :email, presence: true, uniqueness: true, length: {minimum:3, maximum:100},
            format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }

  has_secure_password
end