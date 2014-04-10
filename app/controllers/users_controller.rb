class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, notice: "Welcome to Shutters #{@user.username}!"
    else
      render "new"
    end
  end

  def show
  end

  def update

    if params[:user][:avatar].nil?
      redirect_to :back, alert: "Select an image to update your avatar."
    else current_user.update(user_params)
      redirect_to root_url, notice: "Avatar updated."
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation, :avatar)
  end
end
