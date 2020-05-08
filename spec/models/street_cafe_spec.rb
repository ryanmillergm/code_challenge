require 'rails_helper'

RSpec.describe StreetCafe, type: :model do
  describe 'validations' do
    it { should validate_presence_of :restaurant_name }
    it { should validate_presence_of :street_address }
    it { should validate_presence_of :post_code }
    it { should validate_presence_of :number_of_chairs }
  end

  describe 'class methods' do

    let!(:sc1) { StreetCafe.create!(restaurant_name: "Street Cafe 1", street_address: "1st st", post_code: "LS1 2AN", number_of_chairs: 25, category: "ls1 medium") }
    let!(:sc2) { StreetCafe.create!(restaurant_name: "Street Cafe 2", street_address: "2st st", post_code: "LS1 2AN", number_of_chairs: 200, category: "ls1 large") }
    let!(:sc3) { StreetCafe.create!(restaurant_name: "Street Cafe 3", street_address: "3rd st", post_code: "LS1 2AN", number_of_chairs: 5, category: "ls1 small") }

    let!(:sc4) { StreetCafe.create!(restaurant_name: "Street Cafe 4", street_address: "4th st", post_code: "LS2 6AA", number_of_chairs: 5, category: "ls2 small") }
    let!(:sc5) { StreetCafe.create!(restaurant_name: "Street Cafe 5", street_address: "5th st", post_code: "LS2 6AA", number_of_chairs: 45, category: "ls2 large") }
    let!(:sc6) { StreetCafe.create!(restaurant_name: "Street Cafe 6", street_address: "6th st", post_code: "LS2 6AA", number_of_chairs: 150, category: "ls2 large") }
    let!(:sc7) { StreetCafe.create!(restaurant_name: "Street Cafe 7", street_address: "7th st", post_code: "LS2 6AA", number_of_chairs: 50, category: "ls2 large") }

    it '.cafes_by_size' do
      expect(StreetCafe.cafes_by_size('small').count).to eq(2)
      expect(StreetCafe.cafes_by_size('small')).to eq([sc3, sc4])
      expect(StreetCafe.cafes_by_size('small').first.category).to eq("ls1 small")
      expect(StreetCafe.cafes_by_size('small').first).to eq(sc3)

      expect(StreetCafe.cafes_by_size('medium').count).to eq(1)
      expect(StreetCafe.cafes_by_size('medium').first.category).to eq("ls1 medium")
      expect(StreetCafe.cafes_by_size('medium').first).to eq(sc1)

      expect(StreetCafe.cafes_by_size('large').count).to eq(4)
      expect(StreetCafe.cafes_by_size('large').first.category).to eq("ls1 large")
      expect(StreetCafe.cafes_by_size('large').first).to eq(sc2)

      expect(StreetCafe.cafes_by_size('medium', 'large').count).to eq(5)

      expect{StreetCafe.cafes_by_size('small', 'medium', 'large')}.to raise_error("Wrong number of arguments. Expecting 1-2.")
      expect{StreetCafe.cafes_by_size}.to raise_error("Wrong number of arguments. Expecting 1-2.")
    end

    it '.concatenate_cafes' do
      medium_and_large_cafes = StreetCafe.cafes_by_size('medium', 'large')

      StreetCafe.concatenate_cafes(StreetCafe.cafes_by_size('medium', 'large'))

      expect(sc1.reload.restaurant_name).to eq("ls1 medium Street Cafe 1")
      expect(sc2.reload.restaurant_name).to eq("ls1 large Street Cafe 2")
    end
  end
end
