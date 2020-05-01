namespace :categorize do
  desc "Import data from Street Cafes 2015-16 CSV file"
    task street_cafes: :environment do

      cafes = StreetCafe.all
      cafes_ordered_by_chairs_in_ls2 = StreetCafe.where("post_code LIKE ?", "LS2%").order(:number_of_chairs).to_ary

      cafes.each do |cafe|
        prefix = cafe.post_code.split(' ').first.downcase
        if prefix == 'ls1'
          cafe.categorize_by_number_of_chairs(prefix)
          p "#{cafe.post_code} category: #{cafe.category}; updated!"
        elsif prefix == 'ls2'
          cafe.categorize_by_chair_percentile(prefix, cafes_ordered_by_chairs_in_ls2)
          p "#{cafe.post_code} category: #{cafe.category}; updated!"
        else
          cafe.update!(category: "other" )
          p "#{cafe.post_code} category: #{cafe.category}; updated!"
        end
      end
    end
end
