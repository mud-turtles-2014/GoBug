class WishlistItemsController < ApplicationController

  def new
    @wishlistitem = WishlistItem.new
  end

  def create
    @current_user = current_user
    @wishlist = Wishlist.find(params[:wishlist_id])
    # @wishlistitem = WishlistItem.new(wishlist_id: params[:wishlist_id], expense_id: params[:expense_id])
    @wishlistitem = WishlistItem.new(wishlist_items_params)

    respond_to do |format|
      if @wishlistitem.save
        format.html { redirect_to wishlist_path(@wishlist), notice: 'Wishlist Item was successfully created.' }
        #format.html { redirect_to @trip, notice: 'Trip was successfully created.' }
        format.json { render :show, status: :created, location: @wishlist }
      else
        format.html { render :new }
        format.json { render json: @wishlist.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @wishlist_item = WishlistItem.where(wishlist_id: params[:wishlist_id], expense_id: params[:expense_id]).first
    @wishlist_item.destroy
    respond_to do |format|
      format.html { redirect_to wishlists_url, notice: 'Wishlist was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def wishlist_items_params
      params.permit(:expense_id, :wishlist_id)
    end

end