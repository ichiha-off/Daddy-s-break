class FavoritesController < ApplicationController

  before_action :authenticate_user!

  def create
    @comment = Comment.find(params[:comment_id])
    favorites = current_user.favorites.new(comment_id: params[:comment_id])
    @comment.create_notification_like(current_user)
    favorites.save
  end

  def destroy
    @comment = Comment.find(params[:comment_id])
    favorites = current_user.favorites.find_by(comment_id: params[:comment_id])
    favorites.destroy
  end

end
