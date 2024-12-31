class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  has_many :referrals, class_name: "Referral", foreign_key: "referrer_id", dependent: :destroy_async
  has_many :referred_users, through: :referrals, source: :referred

  validates :first_name, presence: { message: "First name is required." }
  validates :last_name, presence: { message: "Last name is required." }
  validates :email, presence: { message: "Email is required." },
                    format: { with: URI::MailTo::EMAIL_REGEXP, message: "Please enter a valid email address." }
  validates :password, presence: { message: "Password is required." }, length: { minimum: 6, message: "Password must be at least 6 characters long." }
end
