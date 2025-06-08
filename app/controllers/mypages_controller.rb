class MypagesController < ApplicationController
  before_action :authenticate_user!

  def show
    # @quiz_histories = current_user.quiz_histories
    # @favorite_samples = current_user.favorite_samples
  end
end
