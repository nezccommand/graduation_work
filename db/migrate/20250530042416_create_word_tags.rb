class CreateWordTags < ActiveRecord::Migration[7.2]
  def change
    create_table :word_tags do |t|
      t.references :word, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
