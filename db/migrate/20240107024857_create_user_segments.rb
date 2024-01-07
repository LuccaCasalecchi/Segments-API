class CreateUserSegments < ActiveRecord::Migration[7.1]
  def change
    create_table :user_segments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :segment, null: false, foreign_key: true

      t.timestamps
    end
  end
end
