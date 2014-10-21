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
     num_of_expenses = params[:number_of_items]
     for i in 0..(num_of_expenses -1) do
        title_param = "title_#{i}"
        cat_param = "cat_#{i}"
        loc_param = "loc_#{i}"
     end
     p title_param
     p cat_param
     p loc_param
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
