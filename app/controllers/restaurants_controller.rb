class RestaurantsController < ApplicationController

    def index
      @restaurants = Restaurant.page(params[:page]).per(9)
      @categories = Category.all
    end

    def show
        @restaurant = Restaurant.find(params[:id])
        @comment = Comment.new
        @comments = @restaurant.comments.order('created_at desc')
    end
end
