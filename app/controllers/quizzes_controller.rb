class QuizzesController < ApplicationController
  def show
    if params[:quiz_start].present?
      session[:quiz_ids] = nil
      session[:answers] = []

      redirect_to quiz_path(id: params[:id]) and return
    end

    if session[:quiz_ids].blank?
      genre1 = Quiz.where(genre: "基本知識").order("RANDOM()").limit(5)
      genre2 = Quiz.where(genre: "対応方法").order("RANDOM()").limit(5)
      session[:quiz_ids] = (genre1 + genre2).map(&:id)
    end

    @index = params[:id].to_i


    quiz_id = session[:quiz_ids][@index - 1]
    @quiz = Quiz.find(quiz_id)
  end

  def answer
    index = params[:id].to_i
    session[:answers][index - 1] = params[:selected_choice]

    if index + 1 > session[:quiz_ids].size
      redirect_to result_quizzes_path
    else
      redirect_to quiz_path(id: index + 1)
    end
  end

  def result
    data = Quiz.calculate_results(session[:quiz_ids], session[:answers])
    @result = data[:result]
    @correct_count = data[:correct_count]
    @total_count = data[:total_count]
    @genre_accuracies = data[:genre_accuracies]
    @weakest_genre = data[:weakest_genre]

    if current_user
      current_user.quiz_histories.create!(
        correct_count: @correct_count,
        total_count: @total_count
      )

      excess_histories = current_user.quiz_histories.order(created_at: :desc).offset(50)
      excess_histories.destroy_all if excess_histories.exists?
    end
  end
end
