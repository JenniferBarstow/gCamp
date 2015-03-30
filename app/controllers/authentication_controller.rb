class AuthenticationController < ApplicationController

  def destroy
    session.clear
    flash[:notice] = "You have successfully logged out"
    redirect_to root_path
  end

  def new
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      if session[:redirect_to] == nil
        redirect_to projects_path
      else
        redirect_to session[:redirect_to], notice: "You have signed in successfully"
      end
    else
      flash[:error] = "Email / Password combination is invalid"
      render :new
    end
  end
end
