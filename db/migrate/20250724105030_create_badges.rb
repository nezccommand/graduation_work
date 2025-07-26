class CreateBadges < ActiveRecord::Migration[7.2]
  def change
    create_table :badges do |t|
      t.string :name, null: false
      t.string :difficulty, null: false
      t.string :genre, null: false
      t.text :description

      t.timestamps
    end
    add_index :badges, [:difficulty, :genre], unique: true
  end
end
