class CommentsController < ApplicationController

  def show
    @topic = Topic.find(params[:topic_id])
    @comment = Comment.find(params[:id])
    @reply = Reply.new
    unless params[:re_reply].blank?
      @re_reply = Reply.find(params[:re_reply])
    end
    @replies = @comment.replies.where(re_reply_id: nil)
  end

  def create
    topic = Topic.find(params[:topic_id])
    comment = current_user.comments.new(comment_params)
    comment.topic_id = topic.id
    comment_topic = comment.topic
    if comment.save
      comment_topic.create_notification_comment(current_user, comment.id)
      flash[:notice] = "コメントを投稿しました！"
      redirect_to topic_path(topic)
    else
      flash[:alert] = "エラーが発生しました。"
      redirect_to topic_path(topic)
    end
  end

  def destroy
    comment = Comment.find_by(id: params[:id], topic_id: params[:topic_id]).destroy
    flash[:notice] = "コメントを削除しました。"
    redirect_to topic_path(params[:topic_id])
  end

  private

  def comment_params
    params.require(:comment).permit(
      :comment,
      :image
    )
  end

end
