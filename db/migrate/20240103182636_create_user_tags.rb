class CreateUserTags < ActiveRecord::Migration[7.1]
  def change
    create_table :user_tags do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :tag, foreign_key: true

      t.timestamps
    end
    add_index :user_tags, [:user_id, :tag_id], unique: true
  end
end
