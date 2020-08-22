class RelationshipsController < ApplicationController

  def create
    if @user = current_user.follow(params[:user_id])
      @user.create_notification_follow(current_user)
      flash[:notice] = 'ユーザーをフォローしました'
      redirect_back(fallback_location: root_path)
    else
      flash.now[:notice] = 'ユーザーのフォローに失敗しました'
      redirect_back(fallback_location: root_path)
    end
  end
  
  def destroy
    if current_user.unfollow(params[:user_id])
      flash[:notice] = 'ユーザーのフォローを解除しました'
      redirect_back(fallback_location: root_path)
    else
      flash.now[:notice] = 'ユーザーのフォロー解除に失敗しました'
      redirect_back(fallback_location: root_path)
    end
  end

  def followers
    @user = User.find(params[:user_id])
    @users = @user.follower_user
  end

  def follows
    @user = User.find(params[:user_id])
    @users = @user.following_user
  end
  
end
