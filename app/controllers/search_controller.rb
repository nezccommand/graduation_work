class SearchController < ApplicationController
  def suggestions
    query = params[:q].to_s.strip
    results = Sample.where("title ILIKE ? OR sample_text ILIKE ?", "%#{query}%", "%#{query}%").limit(10)

    render json: results.map { |s| { title: s.title } }
  end
end
