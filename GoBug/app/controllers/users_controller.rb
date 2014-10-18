class UsersController < ApplicationController

  def show
    @user = current_user
    @trips = @user.trips
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Successful Signup! Now you can Login"
      redirect_to root_path
    else
      flash[:alert] = @user.errors.full_messages
      render :new
    end
  end

  def destroy
    @user.destroy
  end

  private

  def user_params
    params.require(:user).permit(:username, :first_name, :last_name, :password, :password_confirmation, :email)
  end
end
