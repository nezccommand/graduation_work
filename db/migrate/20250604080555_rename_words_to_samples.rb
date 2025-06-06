class RenameWordsToSamples < ActiveRecord::Migration[7.2]
  def change
    rename_table :words, :samples
  end
end
