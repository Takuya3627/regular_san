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
    @restaurant_comment = current_user.restaurant_comments.new(restaurant_comment_params)
    @restaurant_comment.restaurant_id = @restaurant.id
    review_count = RestaurantComment.where(restaurant_id: params[:restaurant_id]).where(user_id: current_user.id).count
    # バリデーションによるエラーがあるか判定
    if @restaurant_comment.valid?
      # バリデーションエラーが無い、且つレビューを一度もしたことない場合
      if review_count < 1
        @restaurant_comment.save
        redirect_to restaurant_restaurant_comments_path(@restaurant.id)
      else
        flash[:danger] = 'レビュー・コメントの投稿は一度までです！'
      end
    end
  end

  def destroy
    @restaurant = Restaurant.find(params[:restaurant_id])
    @restaurant_comment = @restaurant.restaurant_comments.find(params[:id])
    @restaurant_comment.destroy
    redirect_to restaurant_restaurant_comments_path(@restaurant.id)
  end

  private

  def restaurant_comment_params
    params.require(:restaurant_comment).permit(:rate, :comment)
  end
end
