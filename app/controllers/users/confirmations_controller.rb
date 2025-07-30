class Users::ConfirmationsController < Devise::ConfirmationsController
  def show
    self.resource = resource_class.confirm_by_token(params[:confirmation_token])
    yield resource if block_given?

    if resource.errors.empty?
      sign_in(resource) # ← ここでログイン
      set_flash_message!(:notice, :confirmed)
      respond_with_navigational(resource) { redirect_to after_confirmation_path_for(resource_name, resource) }
    else
      respond_with_navigational(resource.errors, status: :unprocessable_entity) { render :new }
    end
  end

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

  protected

  def after_confirmation_path_for(resource_name, resource)
    root_path # ← トップページに遷移
  end
end
