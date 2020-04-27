class StreetCafe < ApplicationRecord
  validates_presence_of :restaurant_name
  validates_presence_of :street_address
  validates_presence_of :post_code
  validates_presence_of :number_of_chairs
end
