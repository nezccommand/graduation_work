class SimulationEmailsController < ApplicationController
  before_action :authenticate_user!

  def new
  end

  def create
    PhishingMailer.send_random_email(current_user).deliver_now
    redirect_to complete_simulation_email_path
  end

  def complete
  end
end