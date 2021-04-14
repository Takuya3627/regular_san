class RestaurantCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    restaurant_comment = current_user.restaurant_comments.new(restaurant_comment_params)
    restaurant_comment.restaurant_id = @restaurant.id
    restaurant_comment.user_id = current_user.id
    restaurant_comment.save
    @restaurant_comment = RestaurantComment.new
    redirect_to reviews_path(restaurant_comment)
  end

  def destroy
    @restaurant = Restaurant.find(params[:restaurant_id])
    @restaurant_comment = @restaurant.restaurant_comments.find(params[:id])
    @restaurant_comment.destroy
    redirect_to reviews_path(restaurant_comment)
  end

  private

  def restaurant_comment_params
    params.require(:restaurant_comment).permit(:rate, :comment)
  end
end
