class Trip < ActiveRecord::Base
  belongs_to :user
  has_many :expenses, as: :expensable

  accepts_nested_attributes_for :expenses, allow_destroy: true

  def calculate_total
      total = 0
      self.expenses.each do |expense|
        total += expense.usd_cost
      end
      return total
  end

  def remaining_budget
    self.budget - self.calculate_total
  end
end
