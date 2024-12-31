class Referral < ApplicationRecord
  attr_accessor :skip_email
  belongs_to :referrer, class_name: "User"
  belongs_to :referred, class_name: "User", optional: true

  enum status: { pending: nil, completed: 1 }

  validates :email, presence: { message: "Email is required." },
                    format: { with: URI::MailTo::EMAIL_REGEXP, message: "please enter a valid email address." },
                    uniqueness: { case_sensitive: false, message: "email is already referred" }

  before_create :generate_token
  after_create_commit :send_referral_email

  private

  def generate_token
    self.token = SecureRandom.hex(20)
  end

  def send_referral_email
    ReferralMailer.referral_email(self).deliver_later unless skip_email
  end
end
