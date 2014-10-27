class User < ActiveRecord::Base
  attr_accessible :name, :email, :age, :password, :password_confirmation
  has_many :journals

  before_save { email.downcase }
  before_create :create_remember_token

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\W+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 200 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  has_secure_password
  validates :password, length: { minimum: 6 } 

  def self.new_remember_token
    SecureRandom.urlsafe_based64
  end

  def self.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end 

  def create_remember_token
    self.remember_token = User.digest(User.new_remember_token)
  end
end