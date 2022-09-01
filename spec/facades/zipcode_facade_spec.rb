require 'rails_helper'

RSpec.describe ZipcodeFacade do
  describe 'create_zipcodes' do
    it 'finds area of zipcodes', :vcr do
      data = ZipcodeFacade.create_zipcodes("80516", 5)

      expect(data).to be_an(Array)
      expect(data.count).to eq(3)
    end
  end
end
