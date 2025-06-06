class SamplesController < ApplicationController
  def index
    @q = Sample.ransack(params[:q])
    @results = @q.result(distinct: true).order(:title).page(params[:page]).per(12)
  end

  def show
    @sample = Sample.find(params[:id])
  end
end
