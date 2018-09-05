class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.boolean :read, default: false
      t.integer :user_id
      t.integer :notifiable_id
      t.string :notifiable_type
      t.index [:user_id, :notifiable_type, :notifiable_id], name: :unique_index, unique: true

      t.timestamps
    end
  end
end
