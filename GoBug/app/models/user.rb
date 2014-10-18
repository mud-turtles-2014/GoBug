class User < ActiveRecord::Base
  has_secure_password

  has_many :trips
  has_many :expenses, through: :trips
end
