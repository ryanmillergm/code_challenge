require 'rails_helper'

RSpec.describe SteetCafe, type: :model do
  describe 'validations' do
    it { should validate_presence_of :restaurant_name }
    it { should validate_presence_of :street_address }
    it { should validate_presence_of :post_code }
    it { should validate_presence_of :number_of_chairs }
  end
end
