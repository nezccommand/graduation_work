class PhishingMailer < ApplicationMailer
  default from: "training@example.com"

  def send_random_email(user)
    @user = user
    template = [ "template_one", "template_two", "template_three", "template_four" ].sample

    subject =
      case template
      when "template_one"
        "【フィッシング詐欺学習室】アカウント情報の検証のお願い【訓練】"
      when "template_two"
        "【フィッシング詐欺学習室】重要なお知らせのご確認のお願い【訓練】"
      when "template_three"
        "【フィッシング詐欺学習室】異常ログインによる取引制限のお知らせ【訓練】"
      when "template_four"
        "【フィッシング詐欺学習室】ポイント進呈手続きのご案内（5,000ポイント）【訓練】"
      else
        "模擬フィッシングメール"
      end

    mail(to: @user.email, subject: subject) do |format|
      format.html { render template }
    end
  end
end
