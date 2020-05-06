require 'rails_helper'
require 'rake'

Rails.application.load_tasks if Rake::Task.tasks.empty?

RSpec.describe "Rake Tasks" do
  describe 'import:street_cafes' do
    it 'imports street cafes from csv file' do
      expect(StreetCafe.count).to eq(0)

      Rake::Task['import:street_cafes'].execute

      expect(StreetCafe.count).to eq(73)
    end
  end
end
