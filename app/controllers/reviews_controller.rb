class ReviewsController < ApplicationController
  def index
    @restaurant_comments = RestaurantComment.all
    @restaurant = Restaurant.all
  end
end
