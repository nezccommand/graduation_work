class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :html, :json

  def after_inactive_sign_up_path_for(resource)
    confirmation_sent_path
  end

  def update
    @user = current_user

    if @user.update_without_password(account_update_params)
      respond_to do |format|
        format.html do
          redirect_to mypage_path, notice: "ユーザー名を更新しました。"
        end
        format.json do
          render json: { message: "ユーザー名を更新しました。" }, status: :ok
        end
      end
    else
      respond_to do |format|
        format.html do
          redirect_to mypage_path, alert: @user.errors.full_messages.join(", ")
        end
        format.json do
          render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
        end
      end
    end
  end

  private

  def account_update_params
    params.require(:user).permit(:name)
  end
end
