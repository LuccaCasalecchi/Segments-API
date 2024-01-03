class CreateSegmentRules < ActiveRecord::Migration[7.1]
  def change
    create_table :segment_rules do |t|
      t.belongs_to :segment, foreign_key: true
      t.string :field
      t.string :operation
      t.text :value

      t.timestamps
    end
  end
end
