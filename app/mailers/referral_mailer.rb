class ReferralMailer < ApplicationMailer
  default template_path: "referral_mailer/referral_email"

  def referral_email(referral)
    @referral = referral
    @referral_url = "#{ENV["REACT_APP_URL"]}?token=#{@referral.token}&tab=sign_up"
    mail(
      to: @referral.email,
      subject: "You've been referred!"
    )
  end
end
