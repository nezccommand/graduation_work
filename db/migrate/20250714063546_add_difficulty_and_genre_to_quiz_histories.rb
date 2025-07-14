class AddDifficultyAndGenreToQuizHistories < ActiveRecord::Migration[7.2]
  def change
    add_column :quiz_histories, :difficulty, :string
    add_column :quiz_histories, :genre, :string
  end
end
