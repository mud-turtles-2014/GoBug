class TripsController < ApplicationController
  before_action :set_trip, only: [:show, :edit, :update, :destroy]
  before_action :require_login, except: [:index]

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
        format.html { redirect_to user_path(@current_user), notice: 'Trip was successfully created.' }
        #format.html { redirect_to @trip, notice: 'Trip was successfully created.' }
        format.json { render :show, status: :created, location: @trip }
      else
        format.html { render :new }
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @trip.update(trip_params)
        format.html { redirect_to @trip, notice: 'Trip was successfully updated.' }
        format.json { render :show, status: :ok, location: @trip }
      else
        format.html { render :edit }
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @trip.destroy
    respond_to do |format|
      format.html { redirect_to trips_url, notice: 'Trip was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def splash
    @search = Expense.search(params[:q])
    @expenses = @search.result.trip
    render 'splash', layout: false
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trip
      @trip = Trip.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trip_params
      params.require(:trip).permit(:name, :description, :budget, :is_published, :is_private)
    end
end
