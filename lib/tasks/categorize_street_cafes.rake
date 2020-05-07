namespace :categorize do
  desc "Import data from Street Cafes 2015-16 CSV file"
    task street_cafes: :environment do

      cafes = StreetCafe.all
      cafes_ordered_by_chairs_in_ls2 = StreetCafe.where("post_code LIKE ?", "LS2%").order(:number_of_chairs).to_ary

      cafes.each do |cafe|
        cc = CafeCategorizer.new(cafe)
        cc.categorize_cafe(cafes_ordered_by_chairs_in_ls2)
      end
    end
end
