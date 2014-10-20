class CreateWishlistItems < ActiveRecord::Migration
  def change
    create_table :wishlist_items do |t|
      t.references :expense
      t.references :wishlist

      t.timestamps
    end
  end
end
