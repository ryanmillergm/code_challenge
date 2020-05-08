require 'rails_helper'
require 'rake'

Rails.application.load_tasks if Rake::Task.tasks.empty?

RSpec.describe "Rake Tasks" do

  let!(:sc1) { StreetCafe.create!(id: 1, restaurant_name: "Street Cafe 1", street_address: "1st st", post_code: "LS1 2AN", number_of_chairs: 25, created_at: '2020-05-07 23:42:36 UTC', updated_at: '2020-05-07 23:42:36 UTC',  category: "ls1 medium") }
  let!(:sc2) { StreetCafe.create!(id: 2, restaurant_name: "Street Cafe 2", street_address: "2nd st", post_code: "LS1 2AN", number_of_chairs: 25, created_at: '2020-05-07 23:42:36 UTC', updated_at: '2020-05-07 23:42:36 UTC',  category: "ls1 medium") }
  let!(:sc3) { StreetCafe.create!(id: 3, restaurant_name: "Street Cafe 3", street_address: "3rd st", post_code: "LS1 2AN", number_of_chairs: 200, created_at: '2020-05-07 23:42:36 UTC', updated_at: '2020-05-07 23:42:36 UTC',  category: "ls1 large") }
  let!(:sc4) { StreetCafe.create!(id: 4, restaurant_name: "Street Cafe 4", street_address: "4th st", post_code: "LS1 2AN", number_of_chairs: 5, created_at: '2020-05-07 23:42:36 UTC', updated_at: '2020-05-07 23:42:36 UTC',  category: "ls1 small") }
  let!(:sc5) { StreetCafe.create!(id: 5, restaurant_name: "Street Cafe 5", street_address: "5th st", post_code: "LS2 2AN", number_of_chairs: 5, created_at: '2020-05-07 23:42:36 UTC', updated_at: '2020-05-07 23:42:36 UTC',  category: "ls2 small") }


  describe 'exports:street_cafes' do
    it 'creates a csv file with small cafes and deletes records' do
      Rake::Task['export:street_cafes'].execute

      csv = File.read("#{Rails.root}/public/street_cafes.csv")
      test_csv = File.read("#{Rails.root}/public/test_street_cafes.csv")

      expect(csv).to eq(test_csv)
    end

    it 'prints no small cafes if none available' do
      Rake::Task['export:street_cafes'].execute

      expect do
        Rake::Task['export:street_cafes'].execute
      end.to output("\"There are no small cafes.\"\n").to_stdout
    end
  end
end
