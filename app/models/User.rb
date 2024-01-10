class User < ApplicationRecord
  has_many :user_tags
  has_many :tags, through: :user_tags

  has_many :user_segments
  has_many :segments, through: :user_segments

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :birth_date, presence: true
  validates :sex, presence: true
end
