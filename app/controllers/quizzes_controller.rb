class QuizzesController < ApplicationController
  def show
    if params[:quiz_start].present?
      session[:quiz_ids] = nil
      session[:answers] = []
      session[:selected_genre] = params[:genre]
      session[:selected_difficulty] = params[:difficulty]

      redirect_to quiz_path(id: params[:id]) and return
    end

  if session[:quiz_ids].blank?
    genre = session[:selected_genre]
    difficulty = session[:selected_difficulty]

    session[:quiz_ids] = Quiz
      .where(genre: genre, difficulty: difficulty)
      .order("RANDOM()")
      .limit(10)
      .pluck(:id)
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
    @difficulty = data[:difficulty]
    @genre = Quiz.find(session[:quiz_ids].first)&.genre

    if current_user
      current_user.quiz_histories.create!(
        correct_count: @correct_count,
        total_count: @total_count,
        difficulty: @difficulty,
        genre: @genre
      )

      current_user.quiz_histories.order(created_at: :desc).offset(10).destroy_all
    end
  end
end
