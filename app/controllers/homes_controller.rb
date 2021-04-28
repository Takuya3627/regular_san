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
      ave = restaurant_comments.average(:rate)
      ave = 0.0 if ave.nil?
      average = if ave == 0.0
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

      # hash => {}
      hash = {restaurant: restaurant, average: average}
      # array => []
      array << hash
    end

    array.sort { |a, b| b[:average] <=> a[:average] }
    # array.map { |item| item.delete(:average) }
    array.first(3)
  end
end
