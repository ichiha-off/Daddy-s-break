class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.integer :topic_id
      t.integer :comment_id
      t.integer :reply_id
      t.integer :visitor_id, null: false
      t.integer :visited_id, null: false
      t.integer :action, null: false
      t.boolean :checked, null: false, default: false

      t.timestamps
    end
  end
end
