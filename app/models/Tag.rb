class Tag < ApplicationRecord
  has_many :user_tags
  has_many :users, through: :user_tags
  has_many :segment_tag_rules
  has_many :segments, through: :segment_tag_rules
end
