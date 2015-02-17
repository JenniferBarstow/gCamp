class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    user.save
    flash[:notice] = "User was successfully created"
    redirect_to users_path(user)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    if user.update(user_params)
      redirect_to users_path(user)
      flash[:notice] = "User was successfully updated"
    else
      render :edit
    end
  end



  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end
end
