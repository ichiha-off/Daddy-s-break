class TopicsController < ApplicationController

  def index
    @topics = Topic.all
  end

  def ranking_index
    
  end

  def new
    @topic = Topic.new
    @categories = Category.where(is_active: "有効" )
  end

  def create
    @topic = Topic.new(topic_params)
    @topic.user_id = current_user.id
    if @topic.save!
      flash[:notice] = "新しくスレッドを作成しました！"
      redirect_to action: :index
    else
      @topics = Topic.all
      flash[:alert] = "エラーが発生しました。"
      render :index
    end
  end

  def show
    @topic = Topic.find(params[:id])
    @comment = Comment.new
    @comments = @topic.comments.page(params[:page]).reverse_order
  end

  def edit
    @topic = Topic.find(params[:id])
    @categories = Category.where(is_active: "有効" )
  end

  def update
    @topic = Topic.find(params[:id])
    if @topic.update(topic_params)
      flash[:notice] = "内容を変更しました。"
      redirect_to action: :edit
    else
      flash[:alert] = "エラーが発生しました。"
      render :edit
    end
  end

  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy
    flash[:notice] = "スレッドを削除しました。"
    redirect_to action: :index
  end

  private

  def topic_params
    params.require(:topic).permit(
      :title,
      :body,
      :image,
      :category_id
    )
  end

end
