class CreateQuizHistories < ActiveRecord::Migration[7.2]
  def change
    create_table :quiz_histories do |t|
      t.integer :correct_count
      t.integer :total_count
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
