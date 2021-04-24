class RestaurantCommentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @restaurant = Restaurant.find(params[:restaurant_id])
    @restaurant_comments = @restaurant.restaurant_comments
        ave = @restaurant_comments.average(:rate)
        # @average = (ave*2.0).round/2.0
        ave = 0.0 if ave.nil?
        @average = if ave == 0.0
          0.0
        elsif (ave <= 0.5) || (ave < 0.8)
          0.5
        elsif ave < 1.3
          1.0
        elsif ave < 1.8
          1.5
        elsif ave < 2.3
          2.0
        elsif ave < 2.8
          2.5
        elsif ave < 3.3
          3.0
        elsif ave < 3.8
          3.5
        elsif ave < 4.3
          4.0
        elsif ave < 5.0
          4.5
        elsif ave == 5.0
          5.0
        else
          0.0
        end
    # redirect_to restaurant_restaurant_comments_path(@restaurant)
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
