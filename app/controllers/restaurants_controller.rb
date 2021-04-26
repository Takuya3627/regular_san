class RestaurantsController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  def index
    array = []
    Restaurant.all.each do |restaurant|
      restaurant_comments = restaurant.restaurant_comments
      average = (restaurant_comments.average(:rate).presence || 0).floor(1)
      hash = {restaurant: restaurant, average: average}
      array << hash
    end
    @restaurants = Kaminari.paginate_array(array).page(params[:page]).per(9)
  end

  def new
    @restaurant = Restaurant.new
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    restaurant_comments = @restaurant.restaurant_comments
    @average = (restaurant_comments.average(:rate).presence || 0).floor(1)
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
    restaurants = @q.result
    category_id = params[:q][:category_id_eq]
    @category = Category.find_by(id: category_id)
    array = []
      restaurants.each do |restaurant|
      restaurant_comments = restaurant.restaurant_comments
      average = (restaurant_comments.average(:rate).presence || 0).floor(1)
      hash = {restaurant: restaurant, average: average}
      array << hash
    end
    @restaurants = Kaminari.paginate_array(array).page(params[:page]).per(9)
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :category_id, :introduction, :image, :address, :home_page_url)
  end
end
