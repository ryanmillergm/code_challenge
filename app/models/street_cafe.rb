class StreetCafe < ApplicationRecord
  validates_presence_of :restaurant_name,
                        :street_address,
                        :post_code,
                        :number_of_chairs


  def categorize_by_number_of_chairs(prefix)
    if number_of_chairs < 10
      update!(category: "#{prefix} small" )
    elsif number_of_chairs >= 10 && number_of_chairs < 100
      update!(category: "#{prefix} medium" )
    else
      update!(category: "#{prefix} small" )
    end
  end

  def categorize_by_chair_percentile(prefix, cafes_ordered_by_chairs_in_ls2)
    cafe = self
    position = cafes_ordered_by_chairs_in_ls2.index(cafe) + 1
    percentile  = (position.to_f / cafes_ordered_by_chairs_in_ls2.count) * 100

    if percentile < 50
      update!(category: "#{prefix} small" )
    elsif percentile > 50
      update!(category: "#{prefix} large" )
    end
  end
end
