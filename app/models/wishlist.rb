class Wishlist < ActiveRecord::Base
  has_many :expenses, as: :expensable
  belongs_to :user

  def calculate_total
    total = 0
    self.expenses.each { |expense| total += expense.usd_cost }
    return total
  end

  def remaining_budget
    self.budget - self.calculate_total
  end
end
