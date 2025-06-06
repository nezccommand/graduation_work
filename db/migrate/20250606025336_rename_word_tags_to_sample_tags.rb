class RenameWordTagsToSampleTags < ActiveRecord::Migration[7.2]
  def change
    rename_table :word_tags, :sample_tags

    rename_column :sample_tags, :word_id, :sample_id

    remove_foreign_key :sample_tags, column: :sample_id
    add_foreign_key :sample_tags, :samples, column: :sample_id
  end
end
