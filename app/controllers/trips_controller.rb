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
    @show_itinerary = false
    @total = @trip.calculate_total
    @current_user = current_user
    @expenses = @trip.expenses
    @wishlists = @current_user.wishlists

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
