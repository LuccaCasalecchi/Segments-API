class Segment < ApplicationRecord
  has_many :segment_rules
  has_many :segment_tag_rules
  has_many :tags, through: :segment_tag_rules

  has_many :user_segments
  has_many :users, through: :user_segments
end
