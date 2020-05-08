namespace :concatenate do
  desc "concatenates category name with beginning of restaurant name for category"
    task street_cafes: :environment do

      medium_and_large_cafes = StreetCafe.cafes_by_size('medium', 'large')

      StreetCafe.concatenate_cafes(medium_and_large_cafes)
    end
end
