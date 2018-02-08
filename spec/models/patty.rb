class Patty < ActiveRecord::Base
  MEAT_TYPES = [
    "beef",
    "chicken",
    "pork"
  ]

  belongs_to :double_hamburger
  validates :meat_type, :inclusion=> { :in => MEAT_TYPES }
end