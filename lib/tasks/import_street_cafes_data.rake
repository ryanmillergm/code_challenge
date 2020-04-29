namespace :import do
  desc "Import data from Street Cafes 2015-16 CSV file"
    task street_cafes: :environment do

      options = {
        header_converters: :symbol,
        headers: true,
        encoding: 'ISO-8859-1'
      }

      CSV.foreach('./lib/tasks/Street Cafes 2015-16.csv', options) do |row|
        cafe = row.to_h
        cafe[:restaurant_name] = cafe.delete(:cafrestaurant_name)
        cafe[:bench_seating] = cafe.delete(nil)
        street_cafe = StreetCafe.create!(cafe ) do |street_cafe|
        end
        if street_cafe.bench_seating
          p "Restaurant Added: #{street_cafe.restaurant_name}, #{street_cafe.street_address}, #{street_cafe.post_code}, Seating: #{street_cafe.number_of_chairs}, Bench Seating: #{street_cafe.bench_seating}"
        else
          p "Restaurant Added: #{street_cafe.restaurant_name}, #{street_cafe.street_address}, #{street_cafe.post_code}, Seating: #{street_cafe.number_of_chairs}"
        end
      end
      p "You have added all your data"
    end
end
