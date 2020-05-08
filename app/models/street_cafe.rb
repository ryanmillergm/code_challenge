class StreetCafe < ApplicationRecord
  validates_presence_of :restaurant_name,
                        :street_address,
                        :post_code,
                        :number_of_chairs

  def self.cafes_by_size(size)
    where("category LIKE ?", "%#{size}")
  end

end
