class Users::PasswordsController < Devise::PasswordsController
  def create
    email = params[resource_name][:email].downcase
    user = resource_class.find_by(email: email)

    target_time = 2
    start_time = Time.now

    if user
      self.resource = resource_class.send_reset_password_instructions(resource_params)
    else
      self.resource = resource_class.new
      sleep(target_time)
    end

    elapsed = Time.now - start_time
    sleep_time = target_time - elapsed
    sleep(sleep_time) if sleep_time.positive?

    respond_with({}, location: password_sent_path)
  end
end
