class Users::ConfirmationsController < Devise::ConfirmationsController
  def create
    email = params[resource_name][:email].downcase
    user = resource_class.find_by(email: email)

    if user
      self.resource = resource_class.send_confirmation_instructions(resource_params)
    else
      self.resource = resource_class.new
    end

    respond_with({}, location: confirmation_sent_path)
  end
end
