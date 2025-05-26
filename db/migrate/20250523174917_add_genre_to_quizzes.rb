class AddGenreToQuizzes < ActiveRecord::Migration[7.2]
  def change
    add_column :quizzes, :genre, :string, null: false
  end
end
