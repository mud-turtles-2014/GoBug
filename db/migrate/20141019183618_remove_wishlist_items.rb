class RemoveWishlistItems < ActiveRecord::Migration
  def change
    drop_table :wishlist_items

    remove_column :expenses, :trip_id
    add_column :expenses, :expensable_id, :integer
    add_column :expenses, :expensable_type, :string
  end
end
