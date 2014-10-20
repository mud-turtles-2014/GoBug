class ExpensesController < ApplicationController
  before_action :set_expense, only: [:show, :edit, :update, :destroy]
  before_action :require_login, except: [:index]
  before_action :clean_usd_cost, only: [:create]
  respond_to :html, :json
  before_action :set_location, only: [:create]

  def index
    @search = Expense.search(params[:q])
    @expenses = @search.result.trip
    @current_user = current_user
    if @current_user
      # @wishlist = @current_user.wishlists.new
      @wishlists = @current_user.wishlists
      default_option = ["Select Wishlist"]
      list_options = @wishlists.all.map{|u| [ u.name, u.id ] }
      @wishlist_options = default_option + list_options
    else
      @is_wishlist = false
    end
  end

  def show
    @expense = Expense.find(params[:id])
  end

  def new
    @trip = Trip.find(params[:trip_id])
    @expense = Expense.new
  end

  def edit
    # @currency_code = Expense.find(params[:id]).currency_code
   # @expense.update(currency_id: @currency_id, usd_cost: @usd_cost)
  end

  def create
    @trip = Trip.find(params[:trip_id])
    @expense = @trip.expenses.new(expense_params)
    @expense.update(usd_cost: @usd_cost)
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

  def update
    if @expense.update(expense_params)
      respond_with @expense
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

  def destroy
    @expense.destroy
    respond_to do |format|
      format.html { redirect_to user_path(current_user), notice: 'Expense was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def add_to_wishlist
      @wishlist = Wishlist.find(params[:wishlist_id])
      @expense = Expense.find(params[:expense_id])
      @new_expense = Expense.new(@expense.attributes)
      @new_expense.expensable = @wishlist
      @new_expense.id = nil
      @new_expense.save
      redirect_to root_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def clean_usd_cost
      @usd_cost = params[:expense][:usd_cost]
      @usd_cost = @usd_cost[0..-5].to_f
    end

    def set_expense
      @expense = Expense.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def expense_params
      params.require(:expense).permit(:cost, :description, :category_id, :date, :location_id, :usd_cost, :currency_id)
    end

    def set_location
      @location = Location.where(name: params[:expense][:location_id]).first_or_create
      params[:expense][:location_id] = @location.id
    end
end
