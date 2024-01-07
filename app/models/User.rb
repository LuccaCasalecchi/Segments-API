class User < ApplicationRecord
  has_many :user_tags
  has_many :tags, through: :user_tags

  has_many :user_segments
  has_many :segments, through: :user_segments
end
