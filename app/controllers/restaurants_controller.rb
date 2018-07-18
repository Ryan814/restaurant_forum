class RestaurantsController < ApplicationController
    before_action :set_restaurant, only: [:show, :dashboard, :favorite, :unfavorite, :like, :unlike]

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
        @restaurant.count_favorites
        redirect_back(fallback_location: root_path)
    end

    def unfavorite
        @restaurant = Restaurant.find(params[:id])
        favorite = Favorite.where(restaurant: @restaurant, user: current_user)
        favorite.destroy_all
        @restaurant.count_favorites
        redirect_back(fallback_location: root_path)
    end

    def like
        @restaurant.likes.create!(user: current_user)
        redirect_back(fallback_location: root_path)
    end

    def unlike
        like = Like.where(restaurant: @restaurant, user: current_user)
        like.destroy_all
        redirect_back(fallback_location: root_path)
    end

    def ranking
        @restaurants = Restaurant.order(favorites_count: :desc).limit(10)
    end

    private

    def set_restaurant
        @restaurant = Restaurant.find(params[:id])
    end
end
