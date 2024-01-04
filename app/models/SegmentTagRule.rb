class SegmentTagRule < ApplicationRecord
  belongs_to :segment
  belongs_to :tag
end
