class User < ActiveRecord::Base
  before_save {self.email.downcase!}
  validates :name, presence: true, length: {maximum: 255}
  validates :email, presence: true, length: {maximum: 255}, format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i},
            uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: { minimum: 6 }
  has_secure_password
end
