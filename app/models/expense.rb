class Expense < ActiveRecord::Base
  belongs_to :category
  belongs_to :currency
  belongs_to :location
  belongs_to :expensable, polymorphic: true
  has_one :user, through: :trip
  scope :trip, -> { where(expensable_type: "Trip")}
  scope :wishlist, -> { where(expensable_type: "Wishlist")}

  fuzzily_searchable :description

  def self.public_expenses
  	joins('inner join trips on expenses.expensable_id = trips.id').where('trips.is_private = false')
  end
end
