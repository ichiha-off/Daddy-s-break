class RepliesController < ApplicationController

  before_action :authenticate_user!

  def create
    topic = Topic.find(params[:topic_id])
    comment = Comment.find(params[:comment_id])
    reply = current_user.replies.new(reply_params)
    reply.comment_id = comment.id
    reply.topic_id = topic.id
    reply.score = Language.get_data(reply_params[:reply])
    if reply.save
      if reply.re_reply.blank?
        reply.create_notification_reply(current_user, comment.id, reply.id, comment.user.id)
      else
        reply.create_notification_reply(current_user, comment.id, reply.id, reply.re_reply.user.id)
      end
      flash[:notice] = "返信しました！"
      redirect_to topic_comment_path(topic, comment)
    else
      flash[:alert] = "エラーが発生しました。"
      redirect_to topic_path(topic)
    end
  end

  def destroy
    reply = Reply.find_by(id: params[:id], comment_id: params[:comment_id]).destroy
    flash[:notice] = "返信内容を削除しました。"
    redirect_to topic_comment_path(params[:topic_id], params[:comment_id])
  end

  private

  def reply_params
    params.require(:reply).permit(
      :reply,
      :re_reply_id,
      :image
    )
  end

end
