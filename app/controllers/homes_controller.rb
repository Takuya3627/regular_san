class HomesController < ApplicationController
  def top
    restaurants = Restaurant.all
    # revieweの総合点
    @restaurants = ranking(restaurants)
    # 居酒屋のランキング
    @izakayas = ranking(restaurants.where(category_id: 1))
    # カフェのランキング
    @caffes = ranking(restaurants.where(category_id: 2))
    # 和食のランキング
    @japanese_foods = ranking(restaurants.where(category_id: 3))
    # 洋食のランキング
    @western_foods = ranking(restaurants.where(category_id: 4))
    # 中華のランキング
    @chineses = ranking(restaurants.where(category_id: 5))
  end

  def about
  end

  private

  def ranking(restaurants)
    array = []
    restaurants.each do |restaurant|
      restaurant_comments = restaurant.restaurant_comments
      average = (restaurant_comments.average(:rate).presence || 0).floor(1)

      # hash => {}
      hash = {restaurant: restaurant, average: average}
      # array => []
      array << hash
    end

    array.sort { |a, b| b[:average] <=> a[:average] }.first(3)

  end
end
