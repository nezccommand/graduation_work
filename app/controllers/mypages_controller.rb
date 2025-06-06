class MypagesController < ApplicationController
  before_action :authenticate_user!

  def show
    # 仮置きデータ例（テーブル未作成なのでコメント）
    # @quiz_histories = current_user.quiz_histories
    # @favorite_samples = current_user.favorite_samples
  end
end
