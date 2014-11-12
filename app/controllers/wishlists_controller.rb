class WishlistsController < ApplicationController
  before_action :set_wishlist, only: [:show, :edit, :update, :destroy]
  respond_to :html, :json
  # GET /wishlists
  # GET /wishlists.json
  def index
    @current_user = current_user
    @wishlists = @current_user.wishlists
  end

  def show
    @current_user = current_user
    @user_wishlists = @current_user.wishlists
    @expenses = @wishlist.expenses
    @is_wishlist = true
  end

  def new
    @current_user = current_user
    @wishlist = @current_user.wishlists.new
  end

  def edit

  end

  def create
    @current_user = current_user
    @wishlist = @current_user.wishlists.new(wishlist_params)

    respond_to do |format|
      if @wishlist.save
        format.html { redirect_to expenses_path }
        format.json { render :show }
      else
        flash[:danger] = "Hrm... try again?"
        format.html { render :new }
        format.json { render :json }
      end
    end
  end

  def update
    if @wishlist.update(wishlist_params)
      respond_with @wishlist
    end
  end

  def destroy
    if @wishlist.destroy
      redirect_to user_path(current_user)
    end
  end

  private
    def set_wishlist
      @wishlist = Wishlist.find(params[:id])
    end

    def wishlist_params
      params.require(:wishlist).permit(:name, :budget)
    end
end
