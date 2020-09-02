class AddTopicIdToReplies < ActiveRecord::Migration[5.2]

  def change
    add_column :replies, :topic_id, :integer
  end

end
