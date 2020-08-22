class SearchesController < ApplicationController

  before_action :authenticate_user!

  def search
    @range = params[:range]
    word = params[:word]
    if word.blank?
      redirect_back(fallback_location: root_path)
      flash[:alert] = "未入力です"
    elsif @range.blank?
      redirect_back(fallback_location: root_path)
      flash[:alert] = "USERSかTHREADSを選択してください"
    elsif @range == 'topic'
      @topic = search_topic(word)
    elsif @range == 'user'
      @user = search_user(word)
    end
  end

  private

  def search_user(word)
    User.where("name LIKE?","%#{word}%")
  end

  def search_topic(word)
    Topic.where("title LIKE?","%#{word}%")
  end

end
