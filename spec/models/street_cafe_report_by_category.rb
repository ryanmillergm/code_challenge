require 'rails_helper'

RSpec.describe StreetCafeReportByCategory, type: :model do
  describe 'class methods' do

    let!(:sc1) { StreetCafe.create!(restaurant_name: "Street Cafe 1", street_address: "1st st", post_code: "LS1 2AN", number_of_chairs: 25, category: "ls1 medium") }
    let!(:sc1_1) { StreetCafe.create!(restaurant_name: "Street Cafe 1", street_address: "1st st", post_code: "LS1 2AN", number_of_chairs: 25, category: "ls1 medium") }
    let!(:sc2) { StreetCafe.create!(restaurant_name: "Street Cafe 2", street_address: "2st st", post_code: "LS1 2AN", number_of_chairs: 200, category: "ls1 large") }
    let!(:sc3) { StreetCafe.create!(restaurant_name: "Street Cafe 3", street_address: "3rd st", post_code: "LS1 2AN", number_of_chairs: 5, category: "ls1 small") }
    let!(:sc3_1) { StreetCafe.create!(restaurant_name: "Street Cafe 3", street_address: "3rd st", post_code: "LS1 2AN", number_of_chairs: 5, category: "ls1 small") }
    let!(:sc3_2) { StreetCafe.create!(restaurant_name: "Street Cafe 3", street_address: "3rd st", post_code: "LS1 2AN", number_of_chairs: 5, category: "ls1 small") }

    let!(:sc4) { StreetCafe.create!(restaurant_name: "Street Cafe 4", street_address: "4th st", post_code: "LS2 6AA", number_of_chairs: 5, category: "ls2 small") }
    let!(:sc4_1) { StreetCafe.create!(restaurant_name: "Street Cafe 4", street_address: "4th st", post_code: "LS2 6AA", number_of_chairs: 10, category: "ls2 small") }
    let!(:sc5) { StreetCafe.create!(restaurant_name: "Street Cafe 5", street_address: "5th st", post_code: "LS2 6AA", number_of_chairs: 45, category: "ls2 large") }
    let!(:sc6) { StreetCafe.create!(restaurant_name: "Street Cafe 6", street_address: "6th st", post_code: "LS2 6AA", number_of_chairs: 150, category: "ls2 large") }
    let!(:sc7) { StreetCafe.create!(restaurant_name: "Street Cafe 7", street_address: "7th st", post_code: "LS2 6AA", number_of_chairs: 50, category: "ls2 large") }

    let!(:sc8) { StreetCafe.create!(restaurant_name: "Street Cafe 8", street_address: "8th st", post_code: "LS3 3AW", number_of_chairs: 15, category: "other") }
    let!(:sc9) { StreetCafe.create!(restaurant_name: "Street Cafe 9", street_address: "9th st", post_code: "LS3 3AW", number_of_chairs: 30, category: "other") }
    let!(:sc10) { StreetCafe.create!(restaurant_name: "Street Cafe 10", street_address: "10th st", post_code: "LS3 3AW", number_of_chairs: 5, category: "other") }

    it 'is readonly' do
      expect { StreetCafeReportByCategory.all[0].update!(post_code: "something else")}.to raise_error
      expect(StreetCafeReportByCategory.all[0].readonly?).to be true
    end

    describe 'validates SQL query data' do

      it 'groups cafes by category' do
        expect(StreetCafeReportByCategory.count).to eq(6)
        expect(StreetCafeReportByCategory.all[0].category).to eq("ls1 large")
        expect(StreetCafeReportByCategory.all[1].category).to eq("ls1 medium")
        expect(StreetCafeReportByCategory.all[2].category).to eq("ls1 small")
        expect(StreetCafeReportByCategory.all[3].category).to eq("ls2 large")
        expect(StreetCafeReportByCategory.all[4].category).to eq("ls2 small")
        expect(StreetCafeReportByCategory.all[5].category).to eq("other")
      end

      it 'total places of street cafes by category' do
        expect(StreetCafeReportByCategory.find_by(category: "ls1 small").total_places).to eq(3)
        expect(StreetCafeReportByCategory.find_by(category: "ls1 medium").total_places).to eq(2)
        expect(StreetCafeReportByCategory.find_by(category: "ls1 large").total_places).to eq(1)
        expect(StreetCafeReportByCategory.find_by(category: "ls2 small").total_places).to eq(2)
        expect(StreetCafeReportByCategory.find_by(category: "ls2 large").total_places).to eq(3)
        expect(StreetCafeReportByCategory.find_by(category: "other").total_places).to eq(3)
      end

      it 'total chairs by category' do
        expect(StreetCafeReportByCategory.find_by(category: "ls1 small").total_chairs).to eq(15)
        expect(StreetCafeReportByCategory.find_by(category: "ls1 medium").total_chairs).to eq(50)
        expect(StreetCafeReportByCategory.find_by(category: "ls1 large").total_chairs).to eq(200)
        expect(StreetCafeReportByCategory.find_by(category: "ls2 small").total_chairs).to eq(15)
        expect(StreetCafeReportByCategory.find_by(category: "ls2 large").total_chairs).to eq(245)
        expect(StreetCafeReportByCategory.find_by(category: "other").total_chairs).to eq(50)
      end
    end
  end
end
