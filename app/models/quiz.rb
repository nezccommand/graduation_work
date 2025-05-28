class Quiz < ApplicationRecord
  has_many :choices, dependent: :destroy
  accepts_nested_attributes_for :choices, allow_destroy: true

  def self.calculate_results(quiz_ids, answer_ids)
    quizzes = find(quiz_ids)

    correct_count = 0
    genre_stats = Hash.new { |h, k| h[k] = { total: 0, correct: 0 } }

    result = quizzes.each_with_index.map do |quiz, i|
      correct_choice = quiz.choices.find_by(is_correct: true)
      selected_choice = Choice.find_by(id: answer_ids[i].to_i)

      is_correct = selected_choice == correct_choice
      correct_count += 1 if is_correct

      genre = quiz.genre
      genre_stats[genre][:total] += 1
      genre_stats[genre][:correct] += 1 if is_correct

      {
        question: quiz.question,
        correct: correct_choice&.content,
        selected: selected_choice&.content,
        is_correct: is_correct,
        choices: quiz.choices.map(&:content),
        explanation: quiz.explanation,
        genre: genre
      }
    end

    genre_accuracies = genre_stats.transform_values do |stat|
      total = stat[:total]
      correct = stat[:correct]
      total > 0 ? (correct.to_f / total * 100).round : 0
    end

    weakest_genre = genre_accuracies.min_by { |_genre, accuracy| accuracy }&.first

    {
      result: result,
      correct_count: correct_count,
      total_count: quizzes.size,
      genre_accuracies: genre_accuracies,
      weakest_genre: weakest_genre
    }
  end
end
