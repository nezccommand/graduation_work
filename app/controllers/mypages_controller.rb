class MypagesController < ApplicationController
  before_action :authenticate_user!

  def show
    @quiz_histories = current_user.quiz_histories.order(created_at: :desc).limit(10)
  end
end
