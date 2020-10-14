class TopicsController < ApplicationController

  before_action :authenticate_user!

  impressionist :actions => [:show], :unique => [:impressionable_id, :ip_address]

  def index
    @topics = Topic.page(params[:page]).reverse_order
    @categories = Category.where(is_active: "有効")
    @category_topics = Topic.where(category_id: params[:category_id]).page(params[:page]).reverse_order
  end

  def today_ranking
    @today = Time.current
    # DESC = 大きい方から小さい方に並ぶ(降順)
    @today_ranking = Topic.order('impressions_count DESC')
                  .where("? <= created_at", @today.yesterday)
                  .where("created_at <= ?", @today).take(10)
    @categories = Category.where(is_active: "有効")
    @category_topics = Topic.where(category_id: params[:category_id])
  end

  def weekly_ranking
    @today = Time.current
    # DESC = 大きい方から小さい方に並ぶ(降順)
    @weekly_ranking = Topic.order('impressions_count DESC')
                  .where("? <= created_at", @today.ago(7.days))
                  .where("created_at <= ?", @today).take(10)
    @categories = Category.where(is_active: "有効")
    @category_topics = Topic.where(category_id: params[:category_id])
  end

  def new
    @topic = Topic.new
    @categories = Category.where(is_active: "有効" )
  end

  def create
    @topic = Topic.new(topic_params)
    @topic.user_id = current_user.id
    if @topic.save
      @topic.create_notification_topic(current_user, @topic.id)
      flash[:notice] = "新しくスレッドを作成しました！"
      redirect_to action: :index
    else
      @topics = Topic.page(params[:page]).reverse_order
      @categories = Category.where(is_active: "有効")
      @category_topics = Topic.where(category_id: params[:category_id])
      flash[:alert] = "エラーが発生しました。"
      render :index
    end
  end

  def show
    @topic = Topic.find(params[:id])
    @topic.impressionist_count(:filter=>:ip_address)
    @comment = Comment.new
    @comments = @topic.comments.page(params[:page])
  end

  def edit
    @topic = Topic.find(params[:id])
    unless @topic.user_id == current_user.id
      redirect_to topics_path
      flash[:alert] = "エラーが発生しました"
    end
  end

  def update
    @topic = Topic.find(params[:id])
    if @topic.update(topic_params)
      flash[:notice] = "内容を変更しました。"
      redirect_to topic_path(@topic)
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
