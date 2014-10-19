class Trip < ActiveRecord::Base
  belongs_to :user
  has_many :expenses, as: :expensable

  accepts_nested_attributes_for :expenses, allow_destroy: true
end
