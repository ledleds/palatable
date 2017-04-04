class RestaurantsController < ApplicationController

  def index
    @restaurants = Restaurant.all
  end

  def show
    # @review = Review.create(review_params)
  end

end
