namespace :categorize do
  desc "categorizes street cafes by number of chairs and percentile"
    task street_cafes: :environment do

      cafes = StreetCafe.all
      cafes_ordered_by_chairs_in_ls2 = StreetCafe.where("post_code LIKE ?", "LS2%").order(:number_of_chairs).to_ary

      cafes.each do |cafe|
        cc = CafeCategorizer.new(cafe)
        cc.categorize_cafe(cafes_ordered_by_chairs_in_ls2)
      end
    end
end
