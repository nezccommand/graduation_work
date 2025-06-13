class CreateEmailLogs < ActiveRecord::Migration[7.2]
  def change
    create_table :email_logs do |t|
      t.references :user, null: false, foreign_key: true
      t.datetime :sent_at

      t.timestamps
    end
  end
end
