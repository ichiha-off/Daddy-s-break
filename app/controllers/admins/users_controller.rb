class Admins::UsersController < ApplicationController

  before_action :authenticate_admin!

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
      @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "更新しました。"
      redirect_to admins_users_path(@user)
    else
      flash[:alert] = "エラーが発生しました。"
      render 'edit'
    end
  end

  private
    def user_params
      params.require(:user).permit(
        :name,
        :email, 
        :is_active
      )
    end

end
