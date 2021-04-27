class UsersController < ApplicationController
  def index
    @users = User.page(params[:page]).per(12)
  end

  def show
    @user = User.find(params[:id])
    @restaurants = @user.restaurants.page(params[:page]).per(6)
  end

  def edit
    @user = User.find(params[:id])
  end

  def favorites
    restaurants = User.find(params[:id]).favorite_restaurants
    array = []
    restaurants.each do |restaurant|
      restaurant_comments = restaurant.restaurant_comments
      average = (restaurant_comments.average(:rate).presence || 0).floor(1)
      hash = {restaurant: restaurant, average: average}
      array << hash
    end
    @restaurants = Kaminari.paginate_array(array).page(params[:page]).per(9)
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash.now[:notice] = "ユーザー内容が更新されました。"
      redirect_to user_path(@user.id)
    else
      flash.now[:alert] = "ユーザー内容の変更に失敗しました。"
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
