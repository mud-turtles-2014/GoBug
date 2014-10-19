class Expense < ActiveRecord::Base
  belongs_to :category
  belongs_to :trip
  belongs_to :currency
  belongs_to :location
  has_many :wishlist_items
  has_many :wishlists, through: :wishlist_items
  has_one :user, through: :trip
end
