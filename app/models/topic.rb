class Topic < ApplicationRecord

  has_many :notifications, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :replies, dependent: :destroy

  attachment :image
  
  belongs_to :user
  belongs_to :category

  is_impressionable counter_cache: true

  validates :body, presence: true
  validates :title, presence: true

  def create_notification_topic(current_user, topic_id)
    temp_ids = current_user.follower_user
    temp_ids.each do |temp_id|
        save_notification_topic(current_user, topic_id, temp_id['id'])
    end
  end

  def save_notification_topic(current_user, topic_id, visited_id)
    notification = current_user.active_notifications.new(
      topic_id: topic_id,
      visited_id: visited_id,
      action: :topic
    )
    notification.save if notification.valid?
  end

  def create_notification_like(current_user)
    # すでに「いいね」されているか検索
    temp = Notification.where(["visitor_id = ? and visited_id = ? and comment_id = ? and action = ? ", current_user.id, user_id, comment_id, :fav])
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

  def create_notification_comment(current_user, comment_id)
    save_notification_comment(current_user, comment_id, user_id)
  end

  def save_notification_comment(current_user, comment_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      topic_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: :comment
    )
    # 自分の投稿に対するコメントの場合は、通知を作成しない
    unless notification.visitor_id == notification.visited_id
      notification.save if notification.valid?
    end
  end

  def topic_score_average
    if self.comments.blank?
      0
    elsif self.replies.blank?
      self.comments.average(:score).round(2)
    else
      ((self.comments.sum(:score) + self.replies.sum(:score)) / (self.comments.length + self.replies.length)).round(2)
    end
  end

end
