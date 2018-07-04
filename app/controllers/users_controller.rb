class UsersController < ApplicationController
  before_action :set_user, only:[:show, :edit, :update]

  def show
    
  end

  def edit
    
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Profile was successfully update"
      redirect_to user_path(@user)
    else
      flash[:alert] = "Profile was failed to update"
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :intro)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
