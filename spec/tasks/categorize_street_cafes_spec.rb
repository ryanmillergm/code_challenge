require 'rails_helper'
require 'rake'

Rails.application.load_tasks if Rake::Task.tasks.empty?

RSpec.describe "Rake Tasks" do
  let!(:sc1) { StreetCafe.create!(restaurant_name: "Street Cafe 1", street_address: "1st st", post_code: "LS1 2AN", number_of_chairs: 25) }
  let!(:sc2) { StreetCafe.create!(restaurant_name: "Street Cafe 2", street_address: "2st st", post_code: "LS1 2AN", number_of_chairs: 200) }
  let!(:sc3) { StreetCafe.create!(restaurant_name: "Street Cafe 3", street_address: "3rd st", post_code: "LS1 2AN", number_of_chairs: 5) }

  let!(:sc4) { StreetCafe.create!(restaurant_name: "Street Cafe 4", street_address: "4th st", post_code: "LS2 6AA", number_of_chairs: 5) }
  let!(:sc5) { StreetCafe.create!(restaurant_name: "Street Cafe 5", street_address: "5th st", post_code: "LS2 6AA", number_of_chairs: 45) }
  let!(:sc6) { StreetCafe.create!(restaurant_name: "Street Cafe 6", street_address: "6th st", post_code: "LS2 6AA", number_of_chairs: 150) }
  let!(:sc7) { StreetCafe.create!(restaurant_name: "Street Cafe 7", street_address: "7th st", post_code: "LS2 6AA", number_of_chairs: 50) }

  let!(:sc8) { StreetCafe.create!(restaurant_name: "Street Cafe 8", street_address: "8th st", post_code: "LS3 3AW", number_of_chairs: 15) }
  let!(:sc9) { StreetCafe.create!(restaurant_name: "Street Cafe 9", street_address: "9th st", post_code: "LS3 3AW", number_of_chairs: 30) }
  let!(:sc10) { StreetCafe.create!(restaurant_name: "Street Cafe 10", street_address: "10th st", post_code: "LS3 3AW", number_of_chairs: 5) }

  describe 'categorize:street_cafes' do
    it 'categorizes street cafes small, medium, large or other' do
      Rake::Task['categorize:street_cafes'].execute

      expect(sc1.reload.category).to eq("ls1 medium")
      expect(sc2.reload.category).to eq("ls1 large")
      expect(sc3.reload.category).to eq("ls1 small")

      expect(sc4.reload.category).to eq("ls2 small")
      expect(sc5.reload.category).to eq("ls2 large")
      expect(sc6.reload.category).to eq("ls2 large")
      expect(sc7.reload.category).to eq("ls2 large")

      expect(sc8.reload.category).to eq("other")
      expect(sc9.reload.category).to eq("other")
      expect(sc10.reload.category).to eq("other")
    end
  end
end
