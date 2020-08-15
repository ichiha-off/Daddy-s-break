class AddReReplyToReply < ActiveRecord::Migration[5.2]
  def change
    add_reference :replies, :re_reply, foreign_key: { to_table: :replies }
  end
end
