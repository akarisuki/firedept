class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, authentication_keys: [:login]

  validates :username ,presence: true, length: { maximum: 20 }
  validates :email, length: { maximum: 50 }, presence: true, uniqueness: true

  #tweets
  has_many :tweets
  attr_writer :login

  # CarrierWaveで利用するUploader
  
  def self.guest
    find_or_create_by!(username: 'ゲスト' ,email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end

  def login
    @login || self.username || self.email || self.encrypted_password
  end

end
