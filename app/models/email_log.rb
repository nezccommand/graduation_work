class EmailLog < ApplicationRecord
  belongs_to :user

  scope :today, -> { where(sent_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day) }
end
