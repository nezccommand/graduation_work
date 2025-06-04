class Word < ApplicationRecord
  has_many :word_tags, dependent: :destroy
  has_many :tags, through: :word_tags
  
  def self.ransackable_attributes(auth_object = nil)
    ["title", "description"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["tags"]
  end
end
