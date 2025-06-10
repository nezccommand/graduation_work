class SimulationEmailsController < ApplicationController
  before_action :authenticate_user!

  def new
    # 説明画面（メール送信ボタンなど）
  end

  def create
    # ランダムなテンプレートでメール送信
    PhishingMailer.send_random_email(current_user).deliver_now
    redirect_to complete_training_email_path
  end

  def complete
    # 送信完了画面
  end
end