class WordsController < ApplicationController
  def index
    @words = Word.order(:title).page(params[:page]).per(12)
  end

  def show
    @word = Word.find(params[:id])
  end
end
