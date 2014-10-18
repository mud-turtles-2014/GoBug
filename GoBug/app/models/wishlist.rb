class Wishlist < ActiveRecord::Base
  has_many :wishlist_items
  has_many :expenses, through: :wishlist_items
  belongs_to :user

end