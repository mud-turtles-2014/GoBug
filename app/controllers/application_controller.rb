class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception, except: [:from_expenses]

  def current_user
    User.find_by_id(session[:user_id])
  end

  def require_login
    unless current_user
      flash[:error] = "You must be logged in to access that section"
      redirect_to trips_path
    end
  end

  def search(params)
    if params
        @public = Expense.public_expenses
        @search = @public.search(params)
        @expenses = @search.result.trip
      if params[:description] != ""
        @fuzzy_description = Expense.find_by_fuzzy_description(params[:description])
        @fuzzy_title = Expense.find_by_fuzzy_title(params[:description])
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
end
