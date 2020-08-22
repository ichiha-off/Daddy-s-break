class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def user_topics
    @user = User.find(params[:user])
    @topics = Topic.where(user_id: params[:user]).page(params[:page]).reverse_order
  end

  def quit
    @user = current_user
  end

  def quit_update
    @user = current_user
    if @user.update(is_active: "無効")
      # ログアウトさせる記述
      reset_session
      redirect_to topics_path
    else
      flash[:alert] = "エラーが発生しました"
      redirect_to user_path(@user)
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "ユーザー情報を更新しました"
      redirect_to user_path(@user)
    else
      flash[:alert] = "エラーが発生しました"
      redirect_to user_path(@user)
    end
  end

  private
  
  def user_params
  	params.require(:user).permit(:name, :email, :introduction, :profile_image)
  end

end
