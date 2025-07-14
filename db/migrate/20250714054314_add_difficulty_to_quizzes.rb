class AddDifficultyToQuizzes < ActiveRecord::Migration[7.2]
  def up
    add_column :quizzes, :difficulty, :string, default: "easy"
    Quiz.update_all(difficulty: "easy")
    change_column_null :quizzes, :difficulty, false
  end

  def down
    remove_column :quizzes, :difficulty
  end
end
