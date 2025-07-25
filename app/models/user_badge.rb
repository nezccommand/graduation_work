class UserBadge < ApplicationRecord
  belongs_to :user
  belongs_to :badge

  validates :rank, presence: true
end
