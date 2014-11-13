class User < ActiveRecord::Base
  has_secure_password

  has_many :trips
  has_many :wishlists
  has_many :expenses, through: :trips

  def has_expense_in_wishlist(target)
  	self.wishlists.each do |wishlist|
  	  wishlist.expenses.each do |expense|
  		return true if Expense.have_same_info(target, expense)
  	  end
  	end
  	false
  end

  def wishlist_id_of(target)
    self.wishlists.each do |wishlist|
      wishlist.expenses.each do |expense|
        return expense.id if Expense.have_same_info(target, expense)
      end
    end
  end

end
