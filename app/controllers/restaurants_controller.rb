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

    def feeds
        @recent_restaurants = Restaurant.order(created_at: :desc).limit(10)
        @recent_comments = Comment.order(created_at: :desc).limit(10)
    end

    def dashboard
        @restaurant = Restaurant.find(params[:id])
    end

    def favorite
        @restaurant = Restaurant.find(params[:id])
        @restaurant.favorites.create!(user: current_user)
        redirect_back(fallback_location: root_path)
    end

    def unfavorite
        @restaurant = Restaurant.find(params[:id])
        favorite = Favorite.where(restaurant: @restaurant, user: current_user)
        favorite.destroy_all
        redirect_back(fallback_location: root_path)
    end
end
