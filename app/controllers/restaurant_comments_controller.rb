class RestaurantCommentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @restaurant = Restaurant.find(params[:restaurant_id])
    @restaurant_comments = @restaurant.restaurant_comments
    restaurant_comments = @restaurant.restaurant_comments
    @average = (restaurant_comments.average(:rate).presence || 0).floor(1)
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    restaurant_comment = current_user.restaurant_comments.new(restaurant_comment_params)
    restaurant_comment.restaurant_id = @restaurant.id
    restaurant_comment.user_id = current_user.id
    if restaurant_comment.save
      flash[:notice] = "レビュー・コメントが投稿されました。"
      redirect_to restaurant_restaurant_comments_path(@restaurant.id)
    else
      flash.now[:alert] = "レビュー・コメントの投稿に失敗しました。"
      render 'restaurants/show'
    end

  end

  def destroy
    @restaurant = Restaurant.find(params[:restaurant_id])
    @restaurant_comment = @restaurant.restaurant_comments.find(params[:id])
    @restaurant_comment.destroy
    flash.now[:alert] = "レビュー・コメントを削除しました。"
    redirect_to restaurant_restaurant_comments_path(@restaurant.id)
  end

  private

  def restaurant_comment_params
    params.require(:restaurant_comment).permit(:rate, :comment)
  end
end
