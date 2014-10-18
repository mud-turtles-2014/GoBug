class Wishlist < ActiveRecord::Base
  has_many :wishlist_items
  has_many :expenses, through: :wishlist_items
  belongs_to :user

  def my_wishlist?(current_user)
    self.user == current_user
  end
end