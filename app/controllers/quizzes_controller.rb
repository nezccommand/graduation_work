class QuizzesController < ApplicationController
  def show
    if params[:quiz_start].present?
      session[:quiz_ids] = nil
      session[:answers] = []

      redirect_to quizzes_show_path(id: params[:id]) and return
    end

    if session[:quiz_ids].blank?
      genre1 = Quiz.where(genre: "基本知識").order("RANDOM()").limit(5)
      genre2 = Quiz.where(genre: "対応方法").order("RANDOM()").limit(5)
      session[:quiz_ids] = (genre1 + genre2).shuffle.map(&:id)
    end

    @index = params[:id].to_i


    quiz_id = session[:quiz_ids][@index - 1]
    @quiz = Quiz.find(quiz_id)
  end

  def answer
    index = params[:id].to_i
    session[:answers][index - 1] = params[:selected_choice]

    if index + 1 > session[:quiz_ids].size
      redirect_to quizzes_result_path
    else
      redirect_to quizzes_show_path(id: index + 1)
    end
  end

  def result
    @quizzes = Quiz.find(session[:quiz_ids])
    @answers = session[:answers]

    @result = @quizzes.each_with_index.map do |quiz, i|
      correct_choice = quiz.choices.find_by(is_correct: true)
      selected_choice_id = @answers[i].to_i
      selected_choice = Choice.find_by(id: selected_choice_id)

      {
        question: quiz.question,
        correct: correct_choice&.content,
        selected: selected_choice&.content,
        is_correct: selected_choice_id == correct_choice&.id
      }
    end
  end
end
