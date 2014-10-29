class User < ActiveRecord::Base
  attr_accessible :name, :email, :age, :password, :password_confirmation
  has_many :journals

  before_save { self.email = email.downcase }
  before_create :create_remember_token

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i  
  validates :email, presence: true, length: { maximum: 200 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  has_secure_password
  validates :password, length: { minimum: 6 }, allow_blank: true
  validates :password_confirmation, length: { minimum: 6 }, allow_blank: true

  def self.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def self.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end 

  def create_remember_token
    self.remember_token = User.digest(User.new_remember_token)
  end
end
