class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.text :text
      t.references :user, foreign_key: {on_delete: :cascade}

      t.timestamps
    end
    add_index :posts, [:user_id, :created_at]
  end
end
