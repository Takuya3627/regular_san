class RestaurantsController < ApplicationController
  before_action :authenticate_user!, only: [:show, :new, :edit]
  before_action :correct_restaurant,only: [:edit]

  # 直打ち禁止 （URL入力で他人の編集画面へ遷移させない）
  def correct_restaurant
        @restaurant = Restaurant.find(params[:id])
    unless @restaurant.id == current_user.id
      flash[:danger] = '不正アクセスが検出されました！'
      redirect_to root_path
    end
  end

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
      redirect_to restaurant_path(@restaurant)
    else
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
