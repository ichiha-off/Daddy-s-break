class CreateReplies < ActiveRecord::Migration[5.2]
  def change
    create_table :replies do |t|
      t.integer :user_id, null: false
      t.integer :comment_id, null: false
      t.text :reply, null: false
      t.string :image_id

      t.timestamps
    end
  end
end
