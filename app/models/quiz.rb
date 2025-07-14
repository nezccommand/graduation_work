class Quiz < ApplicationRecord
  has_many :choices, dependent: :destroy
  accepts_nested_attributes_for :choices, allow_destroy: true

  enum difficulty: { easy: "easy", hard: "hard" }

def self.calculate_results(quiz_ids, answer_ids)
  quizzes = find(quiz_ids)

  correct_count = 0

  result = quizzes.each_with_index.map do |quiz, i|
    correct_choice = quiz.choices.find_by(is_correct: true)
    selected_choice = Choice.find_by(id: answer_ids[i].to_i)

    is_correct = selected_choice == correct_choice
    correct_count += 1 if is_correct

    {
      question: quiz.question,
      correct: correct_choice&.content,
      selected: selected_choice&.content,
      is_correct: is_correct,
      choices: quiz.choices.map(&:content),
      explanation: quiz.explanation,
      genre: quiz.genre
    }
  end

  difficulty = quizzes.first&.difficulty

  {
    result: result,
    correct_count: correct_count,
    total_count: quizzes.size,
    difficulty: difficulty
  }
end
end
