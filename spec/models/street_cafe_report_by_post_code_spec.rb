require 'rails_helper'

RSpec.describe StreetCafeReportByPostCode, type: :model do
  describe 'class methods' do

    let!(:sc1) { StreetCafe.create!(restaurant_name: "Street Cafe 1", street_address: "1st st", post_code: "LS1 2AN", number_of_chairs: 10) }
    let!(:sc2) { StreetCafe.create!(restaurant_name: "Street Cafe 2", street_address: "2st st", post_code: "LS1 2AN", number_of_chairs: 15) }
    let!(:sc3) { StreetCafe.create!(restaurant_name: "Street Cafe 3", street_address: "3rd st", post_code: "LS1 2AN", number_of_chairs: 5) }

    let!(:sc4) { StreetCafe.create!(restaurant_name: "Street Cafe 4", street_address: "4th st", post_code: "LS2 6AA", number_of_chairs: 3) }
    let!(:sc5) { StreetCafe.create!(restaurant_name: "Street Cafe 5", street_address: "5th st", post_code: "LS2 6AA", number_of_chairs: 2) }
    let!(:sc6) { StreetCafe.create!(restaurant_name: "Street Cafe 6", street_address: "6th st", post_code: "LS2 6AA", number_of_chairs: 5) }
    let!(:sc7) { StreetCafe.create!(restaurant_name: "Street Cafe 7", street_address: "7th st", post_code: "LS2 6AA", number_of_chairs: 10) }

    let!(:sc8) { StreetCafe.create!(restaurant_name: "Street Cafe 8", street_address: "8th st", post_code: "LS3 3AW", number_of_chairs: 15) }
    let!(:sc9) { StreetCafe.create!(restaurant_name: "Street Cafe 9", street_address: "9th st", post_code: "LS3 3AW", number_of_chairs: 30) }
    let!(:sc10) { StreetCafe.create!(restaurant_name: "Street Cafe 10", street_address: "10th st", post_code: "LS3 3AW", number_of_chairs: 5) }

    describe 'sum of all percentages from all post codes is 100%' do
      it 'chair percentage from all post codes sum equals 100' do
        expect(StreetCafeReportByPostCode.sum(:chair_pct).to_i).to eq(100)
      end
    end
  end

  describe 'instance methods' do

  end
end
