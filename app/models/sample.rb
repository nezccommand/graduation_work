class Sample < ApplicationRecord
  has_many :sample_tags, dependent: :destroy
  has_many :tags, through: :sample_tags

  def self.ransackable_attributes(auth_object = nil)
    [ "title", "sample_text" ]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "tags" ]
  end
end
