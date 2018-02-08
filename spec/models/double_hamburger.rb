class DoubleHamburger < ActiveRecord::Base
  has_many :patties, index_errors: true
  has_many :cheese_slices

  accepts_nested_attributes_for :patties
  accepts_nested_attributes_for :cheese_slices
end
