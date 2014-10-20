class Location < ActiveRecord::Base
  has_many :expenses
  fuzzily_searchable :name
end
