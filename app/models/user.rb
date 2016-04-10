class User < ActiveRecord::Base
  belongs_to :city
  has_many :comments #, dependent: :destroy
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

  ### My database methods

  #same as update_attributes but unsafe and lame
  def my_update_attributes(attributes)
    self.name = attributes[:name] unless attributes[:name].nil?
    self.email = attributes[:email] unless attributes[:email].nil?
    self.password = attributes[:password] unless attributes[:password].nil?
    self.password_confirmation = attributes[:password_confirmation] unless attributes[:password_confirmation].nil?
    self.description = attributes[:description] unless attributes[:description].nil?
    self.city_id = attributes[:city_id] unless attributes[:city_id].nil?
    self.birthday = attributes[:birthday] unless attributes[:birthday].nil?
    return false unless self.valid?

    sql="
      UPDATE users
      SET name='#{self.name}', email='#{self.email}', updated_at=localtimestamp, password_digest='#{self.password_digest}',
        description='#{self.description}', city_id='#{self.city_id}', birthday='#{self.birthday}'
      WHERE id=#{self.id};
    "

    ActiveRecord::Base.connection.execute sql
    self
  end

  #same as destroy but unsafe and lame
  def my_destroy
    sql = "
      BEGIN;
      DELETE FROM comments AS c
      WHERE c.user_id=#{self.id};
      DELETE FROM users AS u
      WHERE u.id=#{self.id};
      COMMIT;
    "
    ActiveRecord::Base.connection.execute sql
  end

  #same as find_by_id but unsafe and lame
  def my_find_by_id

  end
end
