class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.references :user, foreign_key: {on_delete: :cascade}
      t.references :post, foreign_key: {on_delete: :cascade}
      
      t.timestamps
    end
    add_index :likes, [:user_id, :post_id], unique: true
  end
end
