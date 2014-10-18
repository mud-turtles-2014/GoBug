class ExpensesController < ApplicationController
  before_action :set_expense, only: [:show, :edit, :update, :destroy]
  before_action :require_login
  before_action :convert_currency, only: [:create, :edit]
  # before_action :clean_usd_cost, only: [:create, :edit]
  respond_to :html, :json

  # GET /expenses
  # GET /expenses.json
  def index
    @search = Expense.search(params[:q])
    @expenses = @search.result
    @trip = Trip.find(params[:trip_id])
    @is_wishlist = false
  end

  # GET /expenses/1
  # GET /expenses/1.json
  def show
    @expense = Expense.find(params[:id])
  end

  # GET /expenses/new
  def new
    @trip = Trip.find(params[:trip_id])
    @expense = Expense.new
  end

  # GET /expenses/1/edit
  def edit
   @expense.update(currency_id: @currency_id, usd_cost: @usd_cost)
  end

  # POST /expenses
  # POST /expenses.json
  def create
    # p "*" * 100
    # p params[:expense][:usd_cost][0..-5]
    # p params[:expense][:usd_cost][0..-5].to_f
    @trip = Trip.find(params[:trip_id])
    @expense = @trip.expenses.new(expense_params)
<<<<<<< HEAD
    @expense.update(currency_id: @currency_id)
      # , usd_cost: @usd_cost)

=======
    puts "*" * 30
    puts @expense
    puts "=" * 30
>>>>>>> master
    respond_to do |format|
      if @expense.save
        puts @expense
        format.html { render partial: 'snippet', locals: {expense: @expense} }
        #format.json { render :show, status: :created, location: @expense }
      #else
        #format.html { render :new }
        #format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /expenses/1
  # PATCH/PUT /expenses/1.json
  def update
    if @expense.update(expense_params)
      respond_with @exepense
    end
    # respond_to do |format|
    #   if @expense.update(expense_params)
    #     format.html { redirect_to expense_path(@expense), notice: 'Expense was successfully updated.' }
    #     format.json { render :show, status: :ok, location: @expense }
    #   else
    #     format.html { render :edit }
    #     format.json { render json: @expense.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # DELETE /expenses/1
  # DELETE /expenses/1.json
  def destroy
    @trip = @expense.trip
    @expense.destroy
    respond_to do |format|
      format.html { redirect_to trip_expenses_path(@trip), notice: 'Expense was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # def clean_usd_cost
    #   @usd_cost = params[:expense][:usd_cost][0..-5].to_f
    # end

    def convert_currency
      @currency_id = Currency.where(code: params[:expense][:currency_id]).first.id
    end

    def set_expense
      @expense = Expense.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def expense_params
<<<<<<< HEAD
      params.require(:expense).permit(:cost, :description, :category_id, :date, :location_id, :usd_cost, :currency_id)
=======
      @location = Location.where(name: params[:expense][:location_id]).first_or_create
      params[:expense][:location_id] = @location.id
      params.require(:expense).permit(:cost, :description, :category_id, :date, :location_id)
>>>>>>> master
    end
end
