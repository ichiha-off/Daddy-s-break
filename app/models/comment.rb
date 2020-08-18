class Comment < ApplicationRecord

  has_many :favorites, dependent: :destroy
  has_many :replies, dependent: :destroy
  has_many :notifications, dependent: :destroy

  attachment :image

  belongs_to :topic
  belongs_to :user

  validates :comment, presence: true

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def create_notification_like(current_user)
    # すでに「いいね」されているか検索
    temp = Notification.where(["visitor_id = ? and visited_id = ? and comment_id = ? and action = ? ", current_user.id, user_id, id, :fav])
    # いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        comment_id: id,
        visited_id: user_id,
        action: :fav
      )
      # 自分の投稿に対するいいねの場合は、通知を作成しない
      unless notification.visitor_id == notification.visited_id
        notification.save if notification.valid?
      end
    end
  end

  def create_notification_reply(current_user, comment_id, reply_id, visited_id)
    notification = current_user.active_notifications.new(
      topic_id: id,
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
