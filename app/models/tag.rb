class Tag < ApplicationRecord
  has_many :word_tags, dependent: :destroy
  has_many :words, through: :word_tags

  def self.ransackable_associations(auth_object = nil)
    ["word_tags", "words"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["id", "name"]
  end
end
