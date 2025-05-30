class CreateWords < ActiveRecord::Migration[7.2]
  def change
    create_table :words do |t|
      t.string :title
      t.string :short_description
      t.text :description
      t.text :sample_text

      t.timestamps
    end
  end
end
