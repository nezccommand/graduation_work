class Admin::WordsController < Admin::BaseController
  before_action :set_word, only: %i[show edit update destroy]

  def index
    @words = Word.all.order(created_at: :desc)
  end

  def show; end

  def new
    @word = Word.new
    @tags = Tag.all
  end

  def create
    @word = Word.new(word_params)
    if @word.save
      redirect_to admin_words_path, notice: "用語を作成しました"
    else
      render :new
    end
  end

  def edit
    @tags = Tag.all
  end

  def update
    if @word.update(word_params)
      redirect_to admin_word_path(@word), notice: "用語を更新しました"
    else
      render :edit
    end
  end

  def destroy
    @word.destroy
    redirect_to admin_words_path, notice: "用語を削除しました"
  end

  private

  def set_word
    @word = Word.find(params[:id])
  end

  def word_params
    params.require(:word).permit(
      :title,
      :short_description,
      :description,
      :sample_text,
      :icon_url,
      tag_ids: []
    )
  end
end
