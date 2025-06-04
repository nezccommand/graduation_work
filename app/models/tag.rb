class Tag < ApplicationRecord
  has_many :sample_tags, dependent: :destroy
  has_many :samples, through: :sample_tags

  def self.ransackable_associations(auth_object = nil)
    ["sample_tags", "samples"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["id", "name"]
  end
end
