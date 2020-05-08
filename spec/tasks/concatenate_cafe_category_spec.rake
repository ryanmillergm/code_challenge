require 'rails_helper'
require 'rake'

binding.pry
Rails.application.load_tasks if Rake::Task.tasks.empty?

RSpec.describe 'concatenate:street_cafes' do
  let!(:sc1) { StreetCafe.create!(restaurant_name: "Street Cafe 1", street_address: "1st st", post_code: "LS1 2AN", number_of_chairs: 25, category: "ls1 medium")) }
  let!(:sc2) { StreetCafe.create!(restaurant_name: "Street Cafe 2", street_address: "2st st", post_code: "LS1 2AN", number_of_chairs: 200, category: "ls1 large")) }
  let!(:sc3) { StreetCafe.create!(restaurant_name: "Street Cafe 3", street_address: "3rd st", post_code: "LS1 2AN", number_of_chairs: 5, category: "ls1 small")) }

  let!(:sc4) { StreetCafe.create!(restaurant_name: "Street Cafe 4", street_address: "4th st", post_code: "LS2 6AA", number_of_chairs: 5, category: "ls2 small")) }
  let!(:sc5) { StreetCafe.create!(restaurant_name: "Street Cafe 5", street_address: "5th st", post_code: "LS2 6AA", number_of_chairs: 45, category: "ls2 large")) }
  let!(:sc6) { StreetCafe.create!(restaurant_name: "Street Cafe 6", street_address: "6th st", post_code: "LS2 6AA", number_of_chairs: 150, category: "ls2 large")) }
  let!(:sc7) { StreetCafe.create!(restaurant_name: "Street Cafe 7", street_address: "7th st", post_code: "LS2 6AA", number_of_chairs: 50, category: "ls2 large")) }

  let!(:sc10) { StreetCafe.create!(restaurant_name: "Street Cafe 10", street_address: "10th st", post_code: "LS3 3AW", number_of_chairs: 5, category: "ls2 other")) }

  it 'categorizes street cafes small, medium, large or other' do
    Rake::Task['concatenate:street_cafes'].execute

    expect(sc1.restaurant_name).to eq("ls1 medium Street Cafe 1")
    expect(sc2.restaurant_name).to eq("ls1 large Street Cafe 2")
    expect(sc3.restaurant_name).to eq("Street Cafe 3")
    expect(sc4.restaurant_name).to eq("Street Cafe 4")
    expect(sc5.restaurant_name).to eq("ls2 large Street Cafe 5")
    expect(sc6.restaurant_name).to eq("ls2 large Street Cafe 6")
    expect(sc10.restaurant_name).to eq("Street Cafe 10")
  end
end
