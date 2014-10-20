class Wishlist < ActiveRecord::Base
  has_many :expenses, as: :expensable
  belongs_to :user
end
