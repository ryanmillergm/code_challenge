require 'rails_helper'

RSpec.describe CafeCategorizer, type: :model do
  describe 'instance methods' do

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

    it '#categorize_cafe' do
      cafes_ordered_by_chairs_in_ls2 = StreetCafe.where("post_code LIKE ?", "LS2%").order(:number_of_chairs).to_ary

      cc1 = CafeCategorizer.new(sc1)
      cc1.categorize_cafe(cafes_ordered_by_chairs_in_ls2)

      cc2 = CafeCategorizer.new(sc2)
      cc2.categorize_cafe(cafes_ordered_by_chairs_in_ls2)

      cc3 = CafeCategorizer.new(sc3)
      cc3.categorize_cafe(cafes_ordered_by_chairs_in_ls2)

      cc4 = CafeCategorizer.new(sc4)
      cc4.categorize_cafe(cafes_ordered_by_chairs_in_ls2)

      cc7 = CafeCategorizer.new(sc7)
      cc7.categorize_cafe(cafes_ordered_by_chairs_in_ls2)

      cc10 = CafeCategorizer.new(sc10)
      cc10.categorize_cafe(cafes_ordered_by_chairs_in_ls2)

      expect(sc1.category).to eq('ls1 medium')
      expect(sc2.category).to eq('ls1 large')
      expect(sc3.category).to eq('ls1 small')

      expect(sc4.category).to eq('ls2 small')
      expect(sc7.category).to eq('ls2 large')

      expect(sc10.category).to eq('other')
    end
  end
end
