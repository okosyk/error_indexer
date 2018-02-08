class DoubleHamburger < ActiveRecord::Base
  has_many :patties, index_errors: true
  accepts_nested_attributes_for :patties
end