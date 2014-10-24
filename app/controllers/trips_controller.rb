require 'pry'
class TripsController < ApplicationController
  before_action :set_trip, only: [:show, :edit, :update, :destroy]
  before_action :require_login, except: [:index, :splash, :show]
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
    @user = User.new
    @show_itinerary = false
    @total = @trip.calculate_total
    @current_user = current_user
    @trip_expenses = @trip.expenses
    @params = params[:q]
    search(@params)

    if @current_user
      # @wishlist = @current_user.wishlists.new
      @wishlists = @current_user.wishlists
      if @wishlists.length == 0
        default_option = ["Add to a new Wishlist"]
      elsif @wishlists.length == 1
        default_option = @wishlists.first.name
      else
        default_option = ["Select Wishlist"]
        list_options = @wishlists.all.map{|u| [ u.name, u.id ] }
        @wishlist_options = default_option + list_options
      end
    else
      @is_wishlist = false
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
    @trip = @current_user.trips.create(name: "Trip from Wishlist", is_published: false, is_private: false)
    num_of_expenses = params[:number_of_items].to_i
    for i in 0..(num_of_expenses-1) do
      title_param = "title_#{i}"
      cat_param = "cat_#{i}"
      loc_param = "loc_#{i}"
      cur_param = "cur_#{i}"
      usd_cost_param = "usd_cost_#{i}"
      foreign_cost_param = "foreign_cost_#{i}"
      binding.pry
      @expense = Expense.new(usd_cost: params["usd_cost_#{i}"].delete("$").to_f, currency_id: Currency.find_by(code:params["cur_#{i}"]).id, cost: (params["foreign_cost_#{i}"]).to_f, title: params["title_#{i}"], location_id: Location.find_by(name: params["loc_#{i}"]).id, category_id: params["cat_#{i}"].to_i, description: "I checked this off my wishlist!", expensable_id: @trip.id, expensable_type: "Trip")
      @expense.save
     end
     sum = 0
     binding.pry
      @trip.expenses.each do |ex|
        sum += ex.usd_cost
      end
    @trip.budget = sum.to_i
    redirect_to user_path(current_user)
  end

  def update
    if @trip.update(trip_params)
      respond_with @trip
    end
  end

  def destroy
    if @trip.destroy
      redirect_to user_path(current_user)
    end
  end

  def splash
    if current_user
      redirect_to expenses_path
    else
      @user = User.new
      @search = Expense.search(params[:q])
      @expenses = @search.result.trip
      render 'splash', layout: false
    end
  end

  private
    def set_trip
      @trip = Trip.find(params[:id])
    end

    def trip_params
      params.require(:trip).permit(:name, :description, :budget, :is_published, :is_private)
    end
end
