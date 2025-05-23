class CreateQuizzes < ActiveRecord::Migration[7.2]
  def change
    create_table :quizzes do |t|
      t.string :question, null: false
      t.text :explanation

      t.timestamps
    end
  end
end
