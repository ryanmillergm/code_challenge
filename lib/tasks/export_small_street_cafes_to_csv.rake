namespace :export do
  desc "Import data from Street Cafes 2015-16 CSV file"
    task street_cafes: :environment do

      require 'csv'

      file = "#{Rails.root}/public/street_cafes.csv"

      small_cafes = StreetCafe.cafes_by_size('small')

      if  small_cafes.empty?
        p 'There are no small cafes.'
      else
        CSV.open( file, 'w' ) do |writer|
          writer << small_cafes.first.attributes.map do |attribute, value|
            attribute
          end
          small_cafes.each do |cafe|
            writer << cafe.attributes.map do |attribute, value|
              value
            end
            StreetCafe.find(cafe.id).destroy
          end
        end
      end
    end
end
