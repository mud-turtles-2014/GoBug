class TripsController < ApplicationController
  before_action :set_trip, only: [:show, :edit, :update, :destroy]
  before_action :require_login, except: [:index, :splash]
  respond_to :html, :json

  def index
    @current_user = current_user
    if @current_user
      @trips = @current_user.trips
    else
      @trips = Trip.all
    end
  end

  def show
    @total = @trip.calculate_total
    @current_user = current_user
    @expenses = @trip.expenses
    @wishlists = @current_user.wishlists
  end

  def new
    @current_user = current_user
    @trip = @current_user.trips.new
    @expense = Expense.new
  end

  def edit
  end

  def create
    @current_user = current_user
    @trip = @current_user.trips.new(trip_params)

    respond_to do |format|
      if @trip.save
        flash[:success] = "Success!"
        format.html { redirect_to user_path(@current_user) }
        format.json { render :show }
      else
        flash[:danger] = "Hrm... try again?"
        format.html { render :new }
        format.json { render :json }
      end
    end
  end

  def from_expenses
    @current_user = current_user
    @trip = @current_user.trips.create(name: "Trip from Wishlist", budget: 0)
     num_of_expenses = params[:number_of_items].to_i
     for i in 0..(num_of_expenses-1) do
        title_param = "title_#{i}"
        cat_param = "cat_#{i}"
        loc_param = "loc_#{i}"
        @expense = Expense.new(title: params["title_#{i}"], location_id: Location.find_by(name: params["loc_#{i}"]).id, category_id: params["cat_#{i}"].to_i, description: "I checked this off my wishlist!", expensable_id: @trip.id, expensable_type: "Trip")
        @expense.save
     end
     redirect_to user_path(current_user)
  end

  def update

    if @trip.update(trip_params)
      flash[:success] = "Success!"
      respond_with @trip
    end
  end

  def destroy
    if @trip.destroy
      flash[:success] = "Success!"
      redirect_to user_path(current_user)
    end
  end

  def splash
    @search = Expense.search(params[:q])
    @expenses = @search.result.trip
    render 'splash', layout: false
  end

  private
    def set_trip
      @trip = Trip.find(params[:id])
    end

    def trip_params
      params.require(:trip).permit(:name, :description, :budget, :is_published, :is_private)
    end
end
