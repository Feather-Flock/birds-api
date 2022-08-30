class ZipcodeFacade
  def self.create_zipcodes(location, distance)
    data = ZipcodeService.get_zipcode_radius(location, distance)
    data[:zip_codes]
  end
end
