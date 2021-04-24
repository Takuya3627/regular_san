class RestaurantsController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  def index
    @restaurants = Restaurant.page(params[:page]).per(9)
  end

  def new
    @restaurant = Restaurant.new
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    @restaurant_comment = RestaurantComment.new
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    @restaurant.user_id = current_user.id
    if @restaurant.save
      redirect_to restaurant_path(@restaurant)
    else
      render :new
    end
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    @restaurant.user_id = current_user.id
    if @restaurant.update(restaurant_params)
      flash.now[:notice] = "お店の内容が更新されました。"
      redirect_to restaurant_path(@restaurant)
    else
      flash.now[:alert] = "お店の内容の変更に失敗しました。"
      render :edit
    end
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    @restaurant.destroy
    redirect_to restaurants_path
  end

  def category
    @restaurants = @q.result
    @restaurant = @restaurants.page(params[:page]).per(9)
    category_id = params[:q][:category_id_eq]
    @category = Category.find_by(id: category_id)
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :category_id, :introduction, :image, :address, :home_page_url)
  end
end
