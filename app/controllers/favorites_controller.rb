class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    favorite = @restaurant.favorites.new(user_id: current_user.id)
    favorite.save
  end

  def destroy
    @restaurant = Restaurant.find(params[:restaurant_id])
    favorite = @restaurant.favorites.find_by(user_id: current_user.id)
    favorite.destroy
  end
end
