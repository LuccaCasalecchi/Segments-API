class CreateSegmentTagRules < ActiveRecord::Migration[7.1]
  def change
    create_table :segment_tag_rules do |t|
      t.belongs_to :segment, foreign_key: true
      t.belongs_to :tag, foreign_key: true

      t.timestamps
    end
  end
end
