class TripsController < ApplicationController
  before_action :set_trip, only: [:show, :edit, :update, :destroy]
  before_action :require_login, except: [:index]

  # GET /trips
  # GET /trips.json
  def index
    @current_user = current_user
    @trips = Trip.all
  end

  # GET /trips/1
  # GET /trips/1.json
  def show
  end

  # GET /trips/new
  def new
    @current_user = current_user
    @trip = @current_user.trips.new
    @expense = @trip.expenses.new
  end

  # GET /trips/1/edit
  def edit
   @trip.build_expense
  end

  # POST /trips
  # POST /trips.json
  def create
    @current_user = current_user
    @trip = @current_user.trips.new(trip_params)
    binding.pry

    respond_to do |format|
      if @trip.save
        format.html { redirect_to trip_path(@trip), notice: 'Trip was successfully created.' }
        #format.html { redirect_to @trip, notice: 'Trip was successfully created.' }
        format.json { render :show, status: :created, location: @trip }
      else
        format.html { render :new }
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trips/1
  # PATCH/PUT /trips/1.json
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

  # DELETE /trips/1
  # DELETE /trips/1.json
  def destroy
    @trip.destroy
    respond_to do |format|
      format.html { redirect_to trips_url, notice: 'Trip was successfully destroyed.' }
      format.json { head :no_content }
    end
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
