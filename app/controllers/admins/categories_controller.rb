class Admins::CategoriesController < ApplicationController

  before_action :authenticate_admin!


  def index
    @categories = Category.all
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "新しいカテゴリを追加しました。"
      redirect_to action: :index
    else
      flash[:alert] = "エラーが発生しました。"
      @categories = Category.all 
      render :index
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      flash[:notice] = "更新しました。"
      redirect_to action: :index
    else
      flash[:alert] = "エラーが発生しました。"
      render :edit
    end
  end

  private

  def category_params
    params.require(:category).permit(
      :name,
      :is_active
    )
  end

end
