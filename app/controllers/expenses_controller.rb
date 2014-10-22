class ExpensesController < ApplicationController
  before_action :set_expense, only: [:show, :edit, :update, :destroy]
  before_action :require_login, except: [:index]
  before_action :clean_usd_cost, only: [:create]
  respond_to :html, :json
  before_action :set_location, only: [:create]

  def index
    @show_itinerary = true

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

    @current_user = current_user
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

  def show
  end

  def new
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
    if @expense.update(expense_params)
      respond_with @expense
    end
  end

  def destroy
    @expense.destroy
    respond_to do |format|
      format.html { redirect_to user_path(current_user) }
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
