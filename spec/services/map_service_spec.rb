require 'rails_helper'

RSpec.describe MapService do
  describe 'get_cords' do
    it 'returns lat and long cords', :vcr do
      cords = MapService.get_cords("Denver,CO")

      expect(cords[:results]).to be_an(Array)

      expect(cords[:results][0][:locations][0][:latLng]).to include :lat, :lng

      expect(cords[:results][0][:locations][0][:latLng][:lat]).to be_a(Float)
      expect(cords[:results][0][:locations][0][:latLng][:lng]).to be_a(Float)
    end
  end
end
