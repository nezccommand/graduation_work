class WordsController < ApplicationController
  def index
    @q = Word.ransack(params[:q])
    @results = @q.result(distinct: true).order(:title).page(params[:page]).per(12)
  end

  def show
    @word = Word.find(params[:id])
  end
end
