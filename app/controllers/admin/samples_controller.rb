class Admin::SamplesController < Admin::BaseController
  before_action :set_sample, only: %i[show edit update destroy]

  def index
    @samples = Sample.all.order(created_at: :desc)
  end

  def show; end

  def new
    @sample = Sample.new
    @tags = Tag.all
  end

  def create
    @sample = Sample.new(sample_params)
    if @sample.save
      redirect_to admin_samples_path, notice: "サンプルを作成しました"
    else
      render :new
    end
  end

  def edit
    @tags = Tag.all
  end

  def update
    if @sample.update(sample_params)
      redirect_to admin_sample_path(@sample), notice: "サンプルを更新しました"
    else
      @errors = @sample.errors.full_messages
      @debug_params = params[:sample].inspect
      render :edit
    end
  end

  def destroy
    @sample.destroy
    redirect_to admin_samples_path, notice: "サンプルを削除しました"
  end

  private

  def set_sample
    @sample = Sample.find(params[:id])
  end

  def sample_params
    params.require(:sample).permit(
      :title,
      :short_description,
      :description,
      :sample_text,
      tag_ids: []
    )
  end
end
