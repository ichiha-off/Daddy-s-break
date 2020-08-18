module NotificationsHelper

  def notification_form(notification)
    @visitor = notification.visitor
    @visitor_comment = notification.comment
    @visitor_reply = notification.reply
    @visitor_topic = notification.topic
    #notification.actionがfollowかfavかcommentかreplyか
    case notification.action
      when "follow" then
        tag.a(@visitor.name, href:user_path(@visitor), style:"font-weight: bold;")+"があなたをフォローしました"
      when "fav" then
        tag.a(@visitor.name, href:user_path(@visitor), style:"font-weight: bold;")+"が"+tag.a('あなたのコメント', href:topic_comment_path(notification.comment.topic.id, @visitor_comment), style:"font-weight: bold;")+"にいいねしました"
      when "comment" then
          @comment = Comment.find_by(id: @visitor_comment)&.comment
          tag.a(@visitor.name, href:user_path(@visitor), style:"font-weight: bold;")+"が"+tag.a('あなたの投稿', href:topic_path(@visitor_topic), style:"font-weight: bold;")+"にコメントしました"
      when "reply" then
          @reply = Reply.find_by(id: @visitor_reply)&.reply
          tag.a(@visitor.name, href:user_path(@visitor), style:"font-weight: bold;")+"が"+tag.a('あなたに', href:topic_comment_path(@visitor_reply.comment.topic, @visitor_comment), style:"font-weight: bold;")+"に返信しました"
      when "topic" then
          @topic = Topic.find_by(id: @visitor_topic)&.title
          tag.a(@visitor.name, href:user_path(@visitor), style:"font-weight: bold;")+"が"+tag.a('新しくスレッド', href:topic_path(@visitor_topic), style:"font-weight: bold;")+"を投稿しました"
    end
  end

  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
  end

end
