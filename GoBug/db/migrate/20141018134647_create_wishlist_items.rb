class CreateWishlistItems < ActiveRecord::Migration
  def change
    create_table :wishlist_items do |t|
      t.references :item
      t.references :wishlist

      t.timestamps
    end
  end
end
