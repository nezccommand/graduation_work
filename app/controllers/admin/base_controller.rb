class Admin::BaseController < ApplicationController
  before_action :require_admin

  private

  def require_admin
    unless current_user&.admin?
      redirect_to root_path, alert: "アクセス権限がありません。", status: :see_other
    end
  end
end
