class Users::RegistrationsController < Devise::RegistrationsController
  protected

  def after_inactive_sign_up_path_for(resource)
    confirmation_sent_path
  end
end
