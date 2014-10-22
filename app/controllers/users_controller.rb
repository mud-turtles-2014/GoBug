class UsersController < ApplicationController
  respond_to :js
  before_action :correct_user, only:[:show]

  def show
    @user = current_user
    if @user.trips
      @trips = @user.trips
      if @trips.last
        @trip = @trips.last
        if @trip.expenses
          @expenses = @trip.expenses
        else
          @expenses = false
        end
      else
        @trip = false
        @expenses = false
      end
      @expense = Expense.new
    else
     @trips = false
     @trip = false
     @expenses = false
    end
    @wishlists = @user.wishlists

     if params[:q]
        @public = Expense.public_expenses
        @search = @public.search(params[:q])
        @expenses = @search.result.trip
      if params[:q][:description] != ""
        @fuzzy_description = Expense.find_by_fuzzy_description(params[:q][:description])
        @fuzzy_title = Expense.find_by_fuzzy_title(params[:q][:description])
        @all_fuzzy = @fuzzy_description + @fuzzy_title
        @fuzzy_results = []
        @fuzzy_search = @all_fuzzy.each {|expense| @fuzzy_results << expense if expense.expensable_type == "Trip"}
        @expenses = @expenses & @fuzzy_search
      end
    else
      @search = Expense.public_expenses.search()
      @expenses = Expense.public_expenses.limit(20).trip
    end
  end

  def from_trip
    @user = current_user
    @trip = Trip.find(params[:trip_id])
    @expense = Expense.new
    @selected = @trip.expenses
    respond_to do |format|
        format.js
    end
  end

  def from_wishlist
    @expense = Expense.new
    @wishlist = Wishlist.find(params[:wishlist_id])
    @selected = Wishlist.find(params[:wishlist_id]).expenses
    respond_to do |format|
        format.js
    end
  end

  def new_trip
    @current_user = current_user
    @trip = @current_user.trips.new
    @expense = Expense.new
    respond_to do |format|
      format.js
    end
  end

  def new_wishlist
    @current_user = current_user
    @wishlist = @current_user.wishlists.new
    respond_to do |format|
      format.js
    end
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

  def correct_user
    unless current_user.id == params[:id].to_i
      redirect_to root_path
    end
  end
end
