class CheeseSlice < ActiveRecord::Base
  CHEESE_TYPES = [
    "edam",
    "camambert"
  ]

  belongs_to :double_hamburger
  validates :cheese_type, :inclusion=> { :in => CHEESE_TYPES }
end
