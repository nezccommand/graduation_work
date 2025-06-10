class PhishingMailer < ApplicationMailer
  default from: "training@example.com"

  def send_random_email(user)
    @user = user
    template = [ "template_one", "template_two" ].sample
    mail(to: @user.email, subject: "模擬フィッシングメール") do |format|
      format.html { render template }
    end
  end
end
