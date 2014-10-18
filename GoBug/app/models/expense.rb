class Expense < ActiveRecord::Base
  belongs_to :category
  belongs_to :trip
  belongs_to :currency
  has_one :user, through: :trip
end
