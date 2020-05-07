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

    it 'is readonly' do
      expect { StreetCafeReportByPostCode.all[0].update!(post_code: "something else")}.to raise_error
      expect(StreetCafeReportByPostCode.all[0].readonly?).to be true
    end

    describe 'validates SQL query data' do

      it 'groups cafes by post code' do
        expect(StreetCafeReportByPostCode.count).to eq(3)
        expect(StreetCafeReportByPostCode.find_by(post_code: "LS1 2AN").total_places).to eq(3)
        expect(StreetCafeReportByPostCode.find_by(post_code: "LS2 6AA").total_places).to eq(4)
        expect(StreetCafeReportByPostCode.find_by(post_code: "LS3 3AW").total_places).to eq(3)
        expect(StreetCafeReportByPostCode.all[0].post_code).to eq("LS1 2AN")
        expect(StreetCafeReportByPostCode.all[1].post_code).to eq("LS2 6AA")
        expect(StreetCafeReportByPostCode.all[2].post_code).to eq("LS3 3AW")
      end

      it 'total places of all post codes to sum up to total street cafes' do
        expect(StreetCafeReportByPostCode.sum(:total_places).to_i).to eq(StreetCafe.count)
      end

      it 'total chairs in a post code' do
        expect(StreetCafeReportByPostCode.find_by(post_code: "LS1 2AN").total_chairs).to eq(StreetCafe.where(post_code: "LS1 2AN").sum(:number_of_chairs))
        expect(StreetCafeReportByPostCode.find_by(post_code: "LS2 6AA").total_chairs).to eq(StreetCafe.where(post_code: "LS2 6AA").sum(:number_of_chairs))
        expect(StreetCafeReportByPostCode.find_by(post_code: "LS3 3AW").total_chairs).to eq(StreetCafe.where(post_code: "LS3 3AW").sum(:number_of_chairs))
      end

      it 'total chairs in post code versus total chairs of all post codes by percentage' do
        all_post_code_total_chairs = StreetCafe.sum(:number_of_chairs)

        ls1_total_chairs = StreetCafe.where(post_code: "LS1 2AN").sum(:number_of_chairs)
        ls2_total_chairs = StreetCafe.where(post_code: "LS2 6AA").sum(:number_of_chairs)
        ls3_total_chairs = StreetCafe.where(post_code: "LS3 3AW").sum(:number_of_chairs)

        ls1_post_code_percentage = ((ls1_total_chairs.to_d / all_post_code_total_chairs) * 100).round(2)
        ls2_post_code_percentage = ((ls2_total_chairs.to_d / all_post_code_total_chairs) * 100).round(2)
        ls3_post_code_percentage = ((ls3_total_chairs.to_d / all_post_code_total_chairs) * 100).round(2)

        expect(StreetCafeReportByPostCode.find_by(post_code: "LS1 2AN").chair_pct).to eq(ls1_post_code_percentage)
        expect(StreetCafeReportByPostCode.find_by(post_code: "LS2 6AA").chair_pct).to eq(ls2_post_code_percentage)
        expect(StreetCafeReportByPostCode.find_by(post_code: "LS3 3AW").chair_pct).to eq(ls3_post_code_percentage)
      end

      it 'sum of all chair percentages from all post codes is 100%' do
        expect(StreetCafeReportByPostCode.sum(:chair_pct).to_i).to eq(100)
      end

      it 'returns street cafe with most chairs in a post code' do
        expect(StreetCafeReportByPostCode.find_by(post_code: "LS1 2AN").place_with_max_chairs).to eq(StreetCafe.where(post_code: "LS1 2AN").max_by { |cafe| cafe.number_of_chairs }.restaurant_name)
        expect(StreetCafeReportByPostCode.find_by(post_code: "LS2 6AA").place_with_max_chairs).to eq(StreetCafe.where(post_code: "LS2 6AA").max_by { |cafe| cafe.number_of_chairs }.restaurant_name)
        expect(StreetCafeReportByPostCode.find_by(post_code: "LS3 3AW").place_with_max_chairs).to eq(StreetCafe.where(post_code: "LS3 3AW").max_by { |cafe| cafe.number_of_chairs }.restaurant_name)
      end
    end
  end
end
