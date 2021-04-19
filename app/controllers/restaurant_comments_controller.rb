class RestaurantCommentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @restaurant = Restaurant.find(params[:restaurant_id])
    @restaurant_comments = @restaurant.restaurant_comments
      if @restaurant.rate >= 0.0
        ave = @restaurant_comments.average(:rate)
        @average = (ave*2.0).round/2.0
      else
        redirect_to restaurant_restaurant_comments_path(@restaurant)
      end
    # 平均値を出す計算式　学習ログ
    # comment_count = @restaurant_comments.count
    # total = 0.0
    # @restaurant_comments.each do |restaurant_comment|
    #   total = restaurant_comment.rate + total
    # end
    # average = total / comment_count
    # bigdecimal = BigDecimal((average).to_s).ceil(2).to_f
    # @bigdecimal = bigdecimal.round(1)
    # @average = @bigdecimal
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    restaurant_comment = current_user.restaurant_comments.new(restaurant_comment_params)
    restaurant_comment.restaurant_id = @restaurant.id
    restaurant_comment.user_id = current_user.id
    restaurant_comment.save
    @restaurant_comment = RestaurantComment.new
    redirect_to restaurant_restaurant_comments_path(@restaurant.id)
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
