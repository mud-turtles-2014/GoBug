class ExpensesController < ApplicationController
  before_action :set_expense, only: [:show, :edit, :update, :destroy]
  before_action :require_login, except: [:index]
  before_action :clean_usd_cost, only: [:create]
  respond_to :html, :json
  before_action :set_location, only: [:create]

  def index
    @user = User.new
    @show_itinerary = true
    @params = params[:q]
    search(@params)
    if current_user
      @current_user = current_user
      @trips = @current_user.trips
      @wishlists = @current_user.wishlists
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
  end

  def show
    @user = User.new
  end

  def new
    @user = User.new
    @trip = Trip.find(params[:trip_id])
    @expense = Expense.new
  end

  def edit
  end

  def create
    @trip = Trip.find(params[:trip_id])
    @expense = @trip.expenses.new(expense_params)
    @expense.update(usd_cost: @usd_cost)
    respond_to do |format|
      if @expense.save
        puts @expense
        format.html { render partial: 'snippet', locals: {expense: @expense} }
      end
    end
  end

  def update
    if params[:usd_cost]
      @expense.update(usd_cost: params[:usd_cost])
      render text:"OK"
    elsif @expense.update(expense_params)
      respond_with @expense
    end
  end

  def destroy
    @expense.destroy
    respond_to do |format|
      format.html { head :no_content }
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
      respond_to do |format|
        format.html { render partial: 'remove_button', :locals => { expense_id: @new_expense.id}}
      end
  end

  private

    def clean_usd_cost
      @usd_cost = params[:expense][:usd_cost]
      @usd_cost = @usd_cost[0..-5].to_f
    end

    def set_expense
      @expense = Expense.find(params[:id])
    end

    def expense_params
      params.require(:expense).permit(:cost, :title, :description, :category_id, :date, :location_id, :usd_cost, :currency_id)
    end

    def set_location
      @location = Location.where(name: params[:expense][:location_id]).first_or_create
      params[:expense][:location_id] = @location.id
    end
end
