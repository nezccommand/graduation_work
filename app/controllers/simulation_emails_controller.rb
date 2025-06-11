class SimulationEmailsController < ApplicationController
  before_action :authenticate_user!

  def new
  end

  def create
    if over_daily_limit?(current_user)
      redirect_to simulation_email_path, alert: "本日はこれ以上メールを送信できません。"
      return
    end

    PhishingMailer.send_random_email(current_user).deliver_now

    PhishingEmailLog.create!(user: current_user, sent_at: Time.zone.now)
    redirect_to complete_simulation_email_path
  end

  def complete
  end

  private

  def over_daily_limit?(user)
    PhishingEmailLog.where(user: user).today.count >= 10
  end
end
