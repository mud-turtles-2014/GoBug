class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    User.find_by_id(session[:user_id])
  end

  def require_login
    unless current_user
      flash[:error] = "You must be logged in to access that section"
      redirect_to trips_path
    end
  end
end
