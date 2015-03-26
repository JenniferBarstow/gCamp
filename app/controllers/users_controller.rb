class UsersController < PrivateController
  before_action :find_and_set_current_user, only: [:show, :edit, :update, :destroy]
  before_action :current_user_not_permitted_access, only: [:edit, :update, :destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "User was successfully created"
      redirect_to users_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "User was successfully updated"
      redirect_to users_path
    else
      render :edit
    end
  end

  def show
  end


  def destroy
      if @user.destroy
        flash[:notice] = "User was successfully deleted"
        redirect_to users_path
      end
    end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

  def find_and_set_current_user
    @user = User.find(params[:id])
  end
end
