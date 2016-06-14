class User < ActiveRecord::Base
  belongs_to :city
  has_many :comments , dependent: :destroy
  has_many :areas
  attr_accessor :remember_token

  before_save { self.email.downcase! }
  validates :name, presence: true, length: {maximum: 255}
  validates :email, presence: true, length: {maximum: 255}, format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i},
            uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: 6}, allow_nil: true
  validates :description, length: {maximum: 300}, allow_nil: true
  has_secure_password

  #hashes passwords
  def User.digest(pass)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
        BCrypt::Engine.cost
    BCrypt::Password.create pass, cost: cost
  end

  #generates token
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  #updates remember digest for new persistent session
  def remember
    self.remember_token = User.new_token
    update_attribute :remember_digest, (User.digest self.remember_token)
  end

  #forgets remember digest. complementary to remember
  def forget
    update_attribute :remember_digest, nil
  end

  #true if token equals digest
  def authenticated? (remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
end
