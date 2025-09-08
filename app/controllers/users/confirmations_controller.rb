class Users::ConfirmationsController < Devise::ConfirmationsController
  def show
    self.resource = resource_class.confirm_by_token(params[:confirmation_token])
    yield resource if block_given?

    if resource.errors.empty?
      sign_in(resource)
      set_flash_message!(:notice, :confirmed)
      respond_with_navigational(resource) { redirect_to after_confirmation_path_for(resource_name, resource) }
    else
      respond_with_navigational(resource.errors, status: :unprocessable_entity) { render :new }
    end
  end

  def create
    email = params[resource_name][:email].downcase
    user = resource_class.find_by(email: email)

    target_time = 2
    start_time = Time.now

    if user
      self.resource = resource_class.send_confirmation_instructions(resource_params)
    else
      self.resource = resource_class.new
      sleep(target_time)
    end

    elapsed = Time.now - start_time
    sleep_time = target_time - elapsed
    sleep(sleep_time) if sleep_time.positive?

    respond_with({}, location: confirmation_sent_path)
  end

  protected

  def after_confirmation_path_for(resource_name, resource)
    root_path
  end
end
