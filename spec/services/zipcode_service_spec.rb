require 'rails_helper'

RSpec.describe ZipcodeService do
  describe 'get_zipcode_radius' do
    it 'returns zipcodes for location', :vcr do
      data = ZipcodeService.get_zipcode_radius('80516', 5)

      expect(data[:zip_codes]).to be_an(Array)
      expect(data[:zip_codes].count).to eq(3)
      expect(data[:zip_codes][0]).to be_a(String)
    end
  end
end
