class Admin::RestaurantsController < Admin::BaseController
  before_action :set_restaurant, only: [:show,:edit,:update, :destroy]

  def index
    #使用Kaminari提供分頁
    @restaurants = Restaurant.page(params[:page]).per(10)
  end

  def new
    @restaurant =  Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      flash[:notice] = "restaurant was successfully created"
      redirect_to admin_restaurants_path
    else
      flash.now[:alert] = "restaurant was failed to create"
      render :new
    end
  end

  #使用before_action傳入變數
  def show
    
  end

  #使用before_action傳入變數
  def edit
    
  end

  #使用before_action傳入變數
  def update
    if @restaurant.update(restaurant_params)
      flash[:notice] = "restaurant was successfully update"
      redirect_to admin_restaurant_path(@restaurant)
    else
      flash[:alert] = "restaurant was failed to update"
      render :edit
    end
  end

  #使用before_action傳入變數
  def destroy
    @restaurant.destroy
    redirect_to admin_restaurants_path
    flash[:alert] = "restaurant was deleted"
  end


  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end

  def restaurant_params
    params.require(:restaurant).permit(:name, :opening_hours, :tel, :address, :description, :image, :category_id)
  end
end
