class Reply < ApplicationRecord

  has_many :notifications, dependent: :destroy
  belongs_to :re_reply,  class_name: "Reply", optional: true
  has_many   :re_replies, class_name: "Reply", foreign_key: :re_reply_id, dependent: :destroy

  attachment :image

  belongs_to :user
  belongs_to :topic
  belongs_to :comment

  def create_notification_reply(current_user, comment_id, reply_id, visited_id)
    notification = current_user.active_notifications.new(
      comment_id: comment_id,
      reply_id: reply_id,
      visited_id: visited_id,
      action: :reply
    )
    unless notification.visitor_id == notification.visited_id
      notification.save if notification.valid?
    end
  end

end
