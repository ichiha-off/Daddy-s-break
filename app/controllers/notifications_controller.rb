class NotificationsController < ApplicationController

  def index
    @notifications = current_user.passive_notifications.page(params[:page]).per(20)
    @notifications_user = @notifications.where.not(visitor_id: current_user.id)
    @notifications.all.each do |notification|
      notification.update_attributes(checked: true)
    end
  end

  def destroy
    @notification = Notification.find(params[:id])
    if @notification.destroy
      flash[:notice] = "通知を一件削除しました"
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = "エラーが発生しました"
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy_all
    @notifications = Notification.where(visited_id: current_user.id)
    if @notifications.destroy_all
      flash[:notice] = "通知を全て削除しました"
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = "エラーが発生しました"
      redirect_back(fallback_location: root_path)
    end
  end
  
end
