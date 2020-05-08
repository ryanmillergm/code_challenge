class StreetCafe < ApplicationRecord
  validates_presence_of :restaurant_name,
                        :street_address,
                        :post_code,
                        :number_of_chairs

  def self.cafes_by_size(*size)
    if size.count == 1
      where("category LIKE ?", "%#{size[0]}")
    elsif size.count == 2
      where("category LIKE ?", "%#{size[0]}").or(where("category LIKE ?", "%#{size[1]}"))
      # where("category LIKE '%#{size[0]}' OR category LIKE '%#{size[1]}'")
    else
      raise ArgumentError, "Wrong number of arguments. Expecting 1-2."
    end
  end

  def self.concatenate_cafes(cafes)
    cafes.map do |cafe|
      name = cafe.category + ' ' + cafe.restaurant_name
      cafe.update!(restaurant_name: name)
    end
  end
end
