require 'rails_helper'

RSpec.describe MapFacade do
  describe 'create_cords' do
    it 'returns lat and long cords', :vcr do
      cords = MapFacade.create_cords('Denver,CO')

      expect(cords).to include :lat, :lng

      expect(cords[:lat]).to be_a(Float)
      expect(cords[:lng]).to be_a(Float)
    end
  end
end
